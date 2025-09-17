import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<GetCurrentLocationRequested>(_onGetCurrentLocationRequested);
  }

  Future<void> _onGetCurrentLocationRequested(GetCurrentLocationRequested event, Emitter<LocationState> emit) async {
    emit(LocationLoadInProgress());
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if(!serviceEnabled) {
        emit(LocationLoadFailure("Location services are disabled"));
        return;
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if(permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if(permission == LocationPermission.denied) {
          emit(LocationLoadFailure("Location services are denied"));
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(const LocationLoadFailure('Location permissions are permanently denied.'));
        return;
      }

      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print("location: ${position.latitude}, ${position.longitude}");

      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.latitude);
      print("place mark: ${placemarks.first}");

      if(placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        final address = '${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}';
        print(address);
        emit(LocationLoadSuccess(address));
      } else {
        emit(LocationLoadFailure("could not determin address from location"));
      }

    } 
     on PlatformException catch (err) {
      // Catch the specific timeout error and provide a clean message
      emit(const LocationLoadFailure('Could not get address. Please check your internet connection.'));
    } catch (e) {
      print(e.toString());
      emit(LocationLoadFailure(e.toString()));
    }
  }




}