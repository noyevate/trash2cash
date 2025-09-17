
import 'package:trash2cash/features/activity/domain/entities/activity_item.dart';
import 'package:trash2cash/features/activity/domain/repositories/activity_repository.dart';

class GetActivities {
  final ActivityRepository repository;

  GetActivities(this.repository);

  Future<List<ActivityItem>> call(ActivityType type) {
    return repository.getActivities(type);
  }
}