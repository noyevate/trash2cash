

import 'package:trash2cash/core/error/exceptions.dart';
import 'package:trash2cash/features/activity/data/datasources/activity_remote_data_source.dart';
import 'package:trash2cash/features/activity/domain/entities/activity_item.dart';
import 'package:trash2cash/features/activity/domain/repositories/activity_repository.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  final ActivityRemoteDataSource remoteDataSource;

  ActivityRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ActivityItem>> getActivities(ActivityType type) {
    // The repository's job is to call the data source and forward the results or errors.
    try {
      // The List<ActivityItemModel> returned by the data source is compatible
      // with the Future<List<ActivityItem>> expected by the domain layer.
      return remoteDataSource.getActivities(type);
    } on ServerException {
      // Catch the exception and re-throw it so the BLoC can handle it.
      rethrow;
    }
  }
}