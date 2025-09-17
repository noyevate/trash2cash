

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trash2cash/features/activity/domain/entities/activity_item.dart';
import 'package:trash2cash/features/activity/domain/usecases/get_activities.dart';

part 'activity_event.dart';
part 'activity_state.dart';





class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final GetActivities _getActivities;

  // A simple cache to hold the data for each tab type.
  final Map<ActivityType, List<ActivityItem>> _cache = {};

  ActivityBloc({required GetActivities getActivities})
      : _getActivities = getActivities,
        super(ActivityInitial()) {
    on<FetchActivitiesRequested>(_onFetchActivitiesRequested);
  }

  Future<void> _onFetchActivitiesRequested(
    FetchActivitiesRequested event,
    Emitter<ActivityState> emit,
  ) async {
    // Optional: If you want to show a loading spinner every time a tab is clicked,
    // even if data is cached, uncomment the line below.
    // emit(ActivityLoadInProgress());

    // Check if we have cached data for this tab type.
    if (_cache.containsKey(event.type)) {
      // If yes, emit the cached data immediately for a fast UX.
      emit(ActivityLoadSuccess(_cache[event.type]!));
      // You can decide if you still want to refresh in the background or just return.
      // For now, we will just return.
      return; 
    }

    // If no data is cached for this type, show loading and fetch it.
    emit(ActivityLoadInProgress());
    try {
      // Call the use case with the requested activity type.
      final activities = await _getActivities(event.type);
      
      // Store the fetched data in the cache.
      _cache[event.type] = activities;

      // Emit the success state with the fetched activities.
      emit(ActivityLoadSuccess(activities));
    } catch (e) {
      // On failure, emit the failure state with the error message.
      emit(ActivityLoadFailure(e.toString()));
    }
  }
}