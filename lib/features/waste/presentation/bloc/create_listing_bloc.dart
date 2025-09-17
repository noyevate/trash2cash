


import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trash2cash/features/waste/domain/entities/waste_listing.dart';
import 'package:trash2cash/features/waste/domain/usecases/create_waste_listing.dart';

part 'create_listing_event.dart';
part 'create_listing_state.dart';


class CreateListingBloc extends Bloc<CreateListingEvent, CreateListingState> {
  final CreateWasteListing _createWasteListing;

  CreateListingBloc({required CreateWasteListing createWasteListing})
      : _createWasteListing = createWasteListing,
        super(CreateListingInitial()) {
    on<SubmitListingRequested>(_onSubmitListingRequested);
  }

  Future<void> _onSubmitListingRequested(
    SubmitListingRequested event,
    Emitter<CreateListingState> emit,
  ) async {
    emit(CreateListingInProgress());
    try {
      final newListing = await _createWasteListing(
        title: event.title,
        description: event.description,
        pickupLocation: event.pickupLocation,
        type: event.type,
        unit: event.unit,
        weight: event.weight,
        contactPhone: event.contactPhone,
        image: event.image,
      );
      emit(CreateListingSuccess(newListing));
    } catch (e) {
      emit(CreateListingFailure(e.toString()));
    }
  }
}