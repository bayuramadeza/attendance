import 'dart:developer';

import 'package:attendance/utils/position.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_state.dart';

const double cameraZoomValue = 19.151926040649414;

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());

  setLocation(double latitude, double longitude)async{
    emit(MapLoading());
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude, localeIdentifier: 'id_ID');
    int index = 0;
    for(int i = 0; i < placemarks.length; i++){
      if(placemarks[i].name!=placemarks[i].street){
        index = i;
        break;
      }
    }
    emit(
      MapLoaded(
        MapWithLocationName(
          name: placemarks[index].name,
          locality: placemarks[index].locality,
          postalCode: placemarks[index].postalCode,
          country: placemarks[index].country,
          street: placemarks[index].street,
          administrativeArea: placemarks[index].administrativeArea,
          subAdministratieArea: placemarks[index].subAdministrativeArea,
          isoCountryCode: placemarks[index].isoCountryCode,
          latitude: latitude,
          longitude: longitude,
          marker: Marker(
            markerId: MarkerId("$latitude, $longitude"),
            position: LatLng(latitude, longitude),
            icon: BitmapDescriptor.defaultMarker,
          ),
          camera: CameraPosition(
            target: LatLng(latitude, longitude),
            zoom: cameraZoomValue
          )
        )
      )
    );
  }

  getCurrentPositionUser()async{
    emit(MapLoading());
    try{
      final position = await determinePosition();
      double latitude = position.latitude;
      double longitude = position.longitude;
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
        emit(
          MapLoaded(
            MapWithLocationName(
              latitude: latitude,
              longitude: longitude,
              name: placemarks[0].name,
              locality: placemarks[0].locality,
              postalCode: placemarks[0].postalCode,
              country: placemarks[0].country,
              street: placemarks[0].street,
              administrativeArea: placemarks[0].administrativeArea,
              subAdministratieArea: placemarks[0].subAdministrativeArea,
              isoCountryCode: placemarks[0].isoCountryCode,
              marker: Marker(
                markerId: MarkerId("$latitude, $longitude"),
                position: LatLng(latitude, longitude),
                icon: BitmapDescriptor.defaultMarker,
              ),
              camera: CameraPosition(
                target: LatLng(latitude, longitude),
                zoom: 19.151926040649414
              )
            )
          )
        );
    } catch(e){
      log(e.toString());
      emit(MapError(e.toString()));
    }
  }
}
