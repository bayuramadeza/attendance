import 'package:attendance/models/nearby_location.dart';
import 'package:attendance/models/user_position_data.dart';
import 'package:attendance/sevices/db/db_service.dart';
import 'package:attendance/sevices/repositories/location_repository.dart';
import 'package:attendance/utils/position.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'checkin_state.dart';

class CheckinCubit extends Cubit<CheckinState> {
  final LocationRepository _repository;
  CheckinCubit(this._repository) : super(CheckinInitial());

  checkIn()async{
    UserPositionData? userPosition;
    if(state is CheckinLoaded){
      userPosition = (state as CheckinLoaded).userPosition;
    } else if(state is CheckinError){
      if((state as CheckinError).userPosition!=null){
        userPosition = (state as CheckinError).userPosition;
      }
    }
    emit(CheckinLoading(userPosition: userPosition));
    if(userPosition!=null){
      if (userPosition.nearby.isInsideRadius) {
        try {
          await Future.delayed(const Duration(seconds: 1));
          emit(CheckinChecked());
        } catch (e) {
          emit(CheckinError(e.toString(), userPosition: userPosition));
        }
      } else {
        emit(CheckinError("Kamu tidak berada dalam radius", userPosition: userPosition));
      }
    }
  }

  getLocation()async{
    emit(const CheckinLoading());

    Position userPosition = await determinePosition();
    try {
      List<NearbyLocation> nearybyList = [];
      final markerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
      
      List<LocationTable> locations = await _repository.getLocations();
      if(locations.isEmpty){
        emit(const CheckinError('Lokasi kehadiran tidak ditemukan'));
      }
      // Mapping from AttendenceLocationModel to UserPositioneData
      List<MarkerAttendence> listMarkerAttendence = locations.map<MarkerAttendence>(
        (value) {
          var markerAttendence = MarkerAttendence(
            circle: Circle(
              fillColor: Colors.red.withOpacity(.5),
              strokeColor: Colors.transparent,
              circleId: CircleId(value.name),
              center: LatLng(value.latitide,
                  value.longitude),
              //TODO: change radius to distance
              radius: 50,
            ),
            locationName: value.name,
            marker: Marker(
              infoWindow: InfoWindow(title: value.name),
              markerId: MarkerId(value.name),
              position: LatLng(value.latitide, value.longitude),
              icon: markerIcon,
            ),
          );

          // Counting range
          double range = Geolocator.distanceBetween(
            userPosition.latitude,
            userPosition.longitude,
            value.latitide,
            value.longitude,
          );

          // Add to list (for sorting), validate is inside radius or not
          nearybyList.add(NearbyLocation(
            latitude: value.latitide,
            longitude: value.longitude,
            radius: 50,
            markerAttendence: markerAttendence,
            isInsideRadius: (range <= 50),
            range: range,
          ));

          return markerAttendence;
        },
      ).toList();

      // Validate nearby
      nearybyList.sort((a, b) => a.range.compareTo(b.range));
      NearbyLocation nearby = nearybyList.elementAt(0);

      emit(CheckinLoaded(UserPositionData(
        listMarker: listMarkerAttendence,
        userPosition: userPosition,
        nearby: nearby,
      )));
    } catch (e) {
      emit(CheckinError(e.toString()));
    }
  }
}
