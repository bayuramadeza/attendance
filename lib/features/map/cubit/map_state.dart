part of 'map_cubit.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

class MapInitial extends MapState {}

class MapLoading extends MapState{}

class MapLoaded extends MapState{
  final MapWithLocationName location;

  const MapLoaded(this.location);
}

class MapError extends MapState{
  final String error;

  const MapError(this.error);
}

class MapWithLocationName{
  double? longitude;
  double? latitude;
  Marker? marker;
  CameraPosition? camera;
  String? country;
  String? locality;
  String? administrativeArea;
  String? postalCode;
  String? street;
  String? name;
  String? subAdministratieArea;
  String? isoCountryCode;

  MapWithLocationName({this.latitude, this.longitude, this.locality, this.marker, this.camera, this.country,
    this.administrativeArea, this.postalCode, this.street, this.name, this.subAdministratieArea, this.isoCountryCode});

  @override
  String toString() {
    return '$street, $subAdministratieArea, $administrativeArea';
  }
}
