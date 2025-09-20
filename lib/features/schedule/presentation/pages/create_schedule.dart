import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/custom_form.dart';
import 'package:trash2cash/constants/format_money.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';
import 'package:trash2cash/features/notification/presentation/bloc/notification_badge_bloc.dart';
import 'package:trash2cash/features/recycler_home/presentation/pages/recycler_home.dart';
import 'package:trash2cash/features/recycler_home_dashboard/presentation/pages/home_dashboard.dart';
import 'package:trash2cash/features/schedule/presentation/bloc/schedule_bloc.dart';
import 'package:trash2cash/features/waste/domain/entities/recycler_waste_listing.dart';
import 'package:intl/intl.dart';

class CreateSchedule extends StatefulWidget {
  const CreateSchedule({super.key, required this.listing});
  final RecyclerWasteListing listing;

  @override
  State<CreateSchedule> createState() => _CreateScheduleState();
}

class _CreateScheduleState extends State<CreateSchedule> {
  final TextEditingController location = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(), // User can't select a past date
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            // Define the colors for the date picker
            colorScheme: ColorScheme.light(
              primary: Tcolor.PrimaryGreen, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Tcolor.PrimaryGreen, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            // Define the colors for the time picker
            colorScheme: ColorScheme.light(
              primary: Tcolor.PrimaryGreen, // Selected number background color
              onPrimary: Colors.white, // Selected number text color
              onSurface: Colors.black, // Clock dial text color
              surface: Colors.white, // Main background color of the dialog
            ),
            // You can also style the text inputs for the clock
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor:
                    Tcolor.PrimaryGreen, // OK and CANCEL button text
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Widget _buildPickerBox({
    required String hintText,
    required String valueText,
    required bool hasValue,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: Colors.grey[200], // Background color from the image
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                hasValue ? valueText : hintText,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: hasValue ? Colors.black87 : Colors.grey[600],
                ),
              ),
              Icon(Icons.keyboard_arrow_down, color: Colors.grey[700]),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    location.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: Container(
          decoration: BoxDecoration(color: Tcolor.PrimaryYellow),
          child: SafeArea(
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Ionicons.arrow_back_circle_outline),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 5.w,
                              right: 15.w,
                            ),
                            child: RText(
                              title: "Create Schedule",
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      )
                    ]),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 15.w, right: 15.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          20.l,
          Container(
            padding: EdgeInsets.all(10.w), // Padding on the parent
            decoration: BoxDecoration(
              color: Tcolor.CustomNarBar,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Row(
              // Align children to the top of the row
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- 1. The Image (with a fixed width) ---
                SizedBox(
                  height: 150.h,
                  width: 130.w, // Give the image a specific, fixed width
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: (widget.listing.imageUrl != null &&
                            widget.listing.imageUrl!.isNotEmpty)
                        ? Image.network(
                            widget.listing.imageUrl!,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, progress) =>
                                progress == null
                                    ? child
                                    : const Center(
                                        child: CircularProgressIndicator()),
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image,
                                    color: Colors.grey, size: 40),
                          )
                        : Container(
                            color: Colors.grey[200],
                            child: const Icon(Icons.image_not_supported,
                                color: Colors.grey, size: 40),
                          ),
                  ),
                ),

                const SizedBox(width: 12), // Spacing between image and text

                // --- 2. The Content (wrapped in Expanded) ---
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.listing.title ?? "Untitled Listing",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            fontFamily: "Metropolis"),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      8.l,
                      RText(
                        title: "${widget.listing.type ?? 'N/A'}",
                        style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                      ),
                      const SizedBox(height: 4),
                      RText(
                        title:
                            "${formatMoney(widget.listing.unit)}unit ${widget.listing.weight?.toStringAsFixed(1) ?? '0'}kg",
                        style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 12.sp,
                            color: Tcolor.PrimaryGreen,
                          ),
                          RText(
                            title: widget.listing.pickupLocation.toString(),
                            style: TextStyle(
                                color: Tcolor.PrimaryGreen, fontSize: 13.sp),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: Tcolor.SecondaryGreenr,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RText(
                              title: widget.listing.status.toString(),
                              style: TextStyle(
                                color: Tcolor.PrimaryGreen,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            CircleAvatar(
                              radius: 3,
                              backgroundColor: Tcolor.PrimaryGreen,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "₦${formatMoney(widget.listing.amount)}",
                        style: TextStyle(
                            color: Tcolor.MoneyColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          10.l,
          20.l,
          RText(
            title: "Payment Method",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold),
          ),
          10.l,
          RText(
              title: "Pickup Location",
              style: TextStyle(
                  color: Color.fromARGB(255, 103, 101, 101), fontSize: 18.sp)),
          CustomForm(
            darkTheme: false,
            prefixIcon: Icon(
              Icons.location_on_outlined,
              color: Tcolor.PrimaryGreen,
              size: 15.sp,
            ),
            hintText: "Enter pick up location",
            color: Color.fromARGB(255, 103, 101, 101),
            controller: location,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                location.text = widget.listing.pickupLocation ?? '';
              });
            },
            child: Padding(
              padding: EdgeInsets.only(left: 30.w),
              child: Row(
                children: [
                  Image.asset("images/target.png"),
                  10.b,
                  RText(
                      title: "Use the waste seller's location",
                      style: TextStyle(
                          color: Tcolor.StaticGreenr,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ),
          ),
          10.l,

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Date Picker Box ---
              _buildPickerBox(
                hintText: 'Select day',
                hasValue: _selectedDate != null,
                // Use DateFormat to make the date look nice (e.g., "Sep 18, 2025")
                valueText: _selectedDate != null
                    ? DateFormat.yMMMd().format(_selectedDate!)
                    : '',
                onTap: () => _selectDate(context),
              ),

              SizedBox(width: 12.w), // Space between the two boxes

              // --- Time Picker Box ---
              _buildPickerBox(
                hintText: '0:00 am',
                hasValue: _selectedTime != null,
                // .format(context) is a handy way to format TimeOfDay (e.g., "11:30 AM")
                valueText:
                    _selectedTime != null ? _selectedTime!.format(context) : '',
                onTap: () => _selectTime(context),
              ),
            ],
          ),

          10.l,

          RText(
            title: "Additional notes (optional)",
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),

          // The multi-line text field
          TextFormField(
            controller: notesController,
            // Allow the field to expand for multiple lines
            maxLines: 4,
            decoration: InputDecoration(
              hintText: "Add special instruction for pickup",
              hintStyle:
                  TextStyle(color: Colors.grey[500], fontFamily: "Metropolis"),
              // Use the grey color from your design
              fillColor: Colors.grey[200],
              filled: true,
              // Creates the rounded border with no underline
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none, // No border line
              ),
            ),
          ),

          20.l,

          BlocConsumer<ScheduleBloc, ScheduleState>(listener: (contxt, state) {
            if (state is ScheduleSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text("Schedule created successfully! ✅"),
                    backgroundColor: Colors.green),
              );
              // After success, pop back to the previous screen (e.g., the details page)
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => RecyclerHome()));
              // context.read<NotificationBadgeBloc>().add(FetchUnreadCount());
            }

            if (state is ScheduleFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(state.error), backgroundColor: Colors.red),
              );
            }
          }, builder: (context, state) {
            final bool isLoading = state is ScheduleInProgress;
            return Column(
              children: [
                GestureDetector(
                  onTap: isLoading
                      ? null
                      : () {
                          // Validate inputs before dispatching
                          if (location.text.isNotEmpty &&
                              _selectedDate != null &&
                              _selectedTime != null) {
                            context.read<ScheduleBloc>().add(
                                  SchedulePickupRequested(
                                    // Use the listingId from the widget property
                                    listingId: widget.listing.id!,
                                    pickupLocation: location.text.trim(),
                                    pickupDate: _selectedDate!,
                                    pickupTime: _selectedTime!,
                                    additionalNotes:
                                        notesController.text.trim().isEmpty
                                            ? null
                                            : notesController.text.trim(),
                                  ),
                                );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Please fill in the location, date, and time.")),
                            );
                          }
                        },
                  child: Container(
                    height: 60.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Tcolor.PrimaryGreen,
                        borderRadius: BorderRadius.circular(30.r)),
                    child: Center(
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white))
                          : RText(
                              title: "Confirm Schedule",
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                    ),
                  ),
                ),
                15.l,
                GestureDetector(
                  onTap: isLoading ? null : () => Navigator.of(context).pop(),
                  child: Container(
                    height: 60.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Tcolor.PrimaryGreen,
                        ),
                        borderRadius: BorderRadius.circular(30.r)),
                    child: Center(
                      child: RText(
                        title: "Cancel",
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: Tcolor.PrimaryGreen,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),

          30.l,
        ]),
      ),
    );
  }
}
