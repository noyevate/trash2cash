part of 'schedule_bloc.dart';

abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object?> get props => [];
}

// This event is dispatched when the user taps the "Confirm Schedule" button.
// It carries all the data collected from the form.
class SchedulePickupRequested extends ScheduleEvent {
  final int listingId;
  final String pickupLocation;
  final DateTime pickupDate;
  final TimeOfDay pickupTime;
  final String? additionalNotes;

  const SchedulePickupRequested({
    required this.listingId,
    required this.pickupLocation,
    required this.pickupDate,
    required this.pickupTime,
    this.additionalNotes,
  });

  @override
  List<Object?> get props => [
        listingId,
        pickupLocation,
        pickupDate,
        pickupTime,
        additionalNotes,
      ];
}