part of 'create_listing_bloc.dart';

abstract class CreateListingEvent extends Equatable {
  const CreateListingEvent();

  @override
  List<Object> get props => [];
}

// This event is dispatched when the user taps the "Submit" button.
// It contains all the data needed to create a new waste listing.
class SubmitListingRequested extends CreateListingEvent {
  final String title;
  final String description;
  final String pickupLocation;
  final Type type;
  final double unit;
  final double weight;
  final String contactPhone;
  final File image;

  const SubmitListingRequested({
    required this.title,
    required this.description,
    required this.pickupLocation,
    required this.type,
    required this.unit,
    required this.weight,
    required this.contactPhone,
    required this.image,
  });

  @override
  List<Object> get props => [
        title,
        description,
        pickupLocation,
        type,
        unit,
        weight,
        contactPhone,
        image,
      ];
}