


import 'package:trash2cash/features/activity/domain/entities/activity_item.dart';

abstract class ActivityRepository {
  // Pass the type to filter by
  Future<List<ActivityItem>> getActivities(ActivityType type);
}