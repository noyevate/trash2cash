// You can create this in a new file, e.g., lib/features/activity/presentation/widgets/activity_list_tab.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trash2cash/features/activity/domain/entities/activity_item.dart';
import 'package:trash2cash/features/activity/presentation/bloc/activity_bloc.dart';
import 'package:trash2cash/features/activity/presentation/widgets/activity_card.dart';
import 'package:intl/intl.dart';
import 'package:trash2cash/features/activity/presentation/widgets/date_header_widgets.dart'; // For formatting dates

class ActivityListTab extends StatefulWidget {
  final ActivityType type;
  const ActivityListTab({super.key, required this.type});

  @override
  State<ActivityListTab> createState() => _ActivityListTabState();
}

class _ActivityListTabState extends State<ActivityListTab> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    // Fetch the data for THIS tab's specific type as soon as it's created.
    // The BLoC's caching logic will prevent re-fetching if the data already exists.
    context.read<ActivityBloc>().add(FetchActivitiesRequested(widget.type));
  }

  // --- This is important to keep the state of each tab when swiping ---
  @override
  bool get wantKeepAlive => true;

   // --- HELPER 1: Group Activities by Day ---
  List<Object> _groupActivitiesByDay(List<ActivityItem> activities) {
    if (activities.isEmpty) return [];

    // Sort activities from newest to oldest
    activities.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    
    final List<Object> itemsWithHeaders = [];
    DateTime? lastDate;

    for (final activity in activities) {
      final activityDate = DateTime(activity.timestamp.year, activity.timestamp.month, activity.timestamp.day);
      if (lastDate == null || activityDate.isBefore(lastDate)) {
        // This is a new day, so add a header
        itemsWithHeaders.add(activityDate);
        lastDate = activityDate;
      }
      // Add the activity itself
      itemsWithHeaders.add(activity);
    }
    return itemsWithHeaders;
  }
  
  // --- HELPER 2: Format the Date for the Header ---
  String _formatDateHeader(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    
    if (date == today) {
      return "Today – ${DateFormat.yMMMMd().format(date)}";
    } else if (date == yesterday) {
      return "Yesterday – ${DateFormat.yMMMMd().format(date)}";
    } else {
      return DateFormat.yMMMMd().format(date); // e.g., "September 15, 2025"
    }
  }


  @override
  Widget build(BuildContext context) {
    super.build(context); // This is required for AutomaticKeepAliveClientMixin
    
    return BlocBuilder<ActivityBloc, ActivityState>(
      builder: (context, state) {
        // --- Case 1: The BLoC is loading data ---
        if (state is ActivityLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        }

        // --- Case 2: The BLoC failed to load data ---
        if (state is ActivityLoadFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Failed to load activities: ${state.error}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<ActivityBloc>().add(FetchActivitiesRequested(widget.type));
                  },
                  child: const Text('Retry'),
                )
              ],
            ),
          );
        }
        
        // --- Case 3: The BLoC has successfully loaded data ---
        if (state is ActivityLoadSuccess) {
          // Filter the list to only show items relevant to the current tab.
          // This is flexible and works well with the "All" tab.
          final relevantActivities = widget.type == ActivityType.ALL
              ? state.activities
              : state.activities.where((activity) => activity.type == widget.type).toList();
          
          if (relevantActivities.isEmpty) {
            return const Center(child: Text("No activities in this category yet."));
          }

          final groupedItems = _groupActivitiesByDay(relevantActivities);
          
          // return ListView.builder(
          //   padding: EdgeInsets.all(16.w),
          //   itemCount: relevantActivities.length,
          //   itemBuilder: (context, index) {
          //     final activity = relevantActivities[index];
          //     return _buildCardFromActivity(activity); // Use a helper to build the card
          //   },
          // );

          return ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: groupedItems.length,
            itemBuilder: (context, index) {
              final item = groupedItems[index];

              // --- BUILD WIDGET BASED ON TYPE ---
              if (item is DateTime) {
                // If the item is a DateTime, build a DateHeader
                return DateHeader(dateText: _formatDateHeader(item));
              } else if (item is ActivityItem) {
                // If the item is an ActivityItem, build an ActivityCard
                return _buildCardFromActivity(item);
              }
              // Fallback, should not happen
              return const SizedBox.shrink();
            },
          );
        }

        // --- Default/Initial state ---
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  // Helper method to convert the ActivityItem entity into the ActivityCard widget
  Widget _buildCardFromActivity(ActivityItem activity) {
    final details = activity.details;

    // Use a switch statement to handle the different types of details
    switch (activity.type) {
      case ActivityType.PAID:
        if (details is PaidActivityDetails) {
          return ActivityCard(
            icon: Icons.recycling,
            iconColor: Tcolor.primaryGreen,
            title: activity.title,
            timestamp: DateFormat.jm().format(activity.timestamp), // e.g., "10:45 AM"
            statusText: "Paid",
            statusColor: Tcolor.lightGreen,
            description: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 15, color: Colors.grey[700], height: 1.4),
                children: [
                  const TextSpan(text: "A recycler has paid "),
                  TextSpan(
                    text: "₦${details.amount.toStringAsFixed(0)}",
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const TextSpan(text: " for your waste."),
                ],
              ),
            ),
            buttonText: "View Details",
            onButtonPressed: () {},
          );
        }
        break;
      case ActivityType.SCHEDULED:
        if (details is ScheduledActivityDetails) {
          return ActivityCard(
            icon: Icons.local_shipping_outlined,
            iconColor: Tcolor.primaryOrange,
            title: activity.title,
            timestamp: DateFormat.jm().format(activity.timestamp),
            statusText: "Scheduled",
            statusColor: Tcolor.lightOrange,
            description: Text(
              "${details.recycler} scheduled pickup for\n${DateFormat.MMMd().add_jm().format(details.scheduledDateTime)}", // e.g., Aug 22, 9:00 AM
              style: TextStyle(fontSize: 15, color: Colors.grey[700], height: 1.4),
            ),
            buttonText: "View Schedule",
            onButtonPressed: () {},
          );
        }
        break;
      case ActivityType.COMPLETED:
        if (details is CompletedActivityDetails) {
           return ActivityCard(
            icon: Icons.check_circle_outline,
            iconColor: Tcolor.primaryBlue,
            title: activity.title,
            timestamp: "Yesterday", // You would add logic to format this properly
            statusText: "Completed",
            statusColor: Tcolor.lightBlue,
            description: Text(
              "${details.recycler} has confirmed pickup.",
              style: TextStyle(fontSize: 15, color: Colors.grey[700], height: 1.4),
            ),
            buttonText: "View Invoice",
            onButtonPressed: () {},
          );
        }
        break;
      default:
        break;
    }
    // Return an empty container if the details type is unknown or mismatched
    return const SizedBox.shrink();
  }
}