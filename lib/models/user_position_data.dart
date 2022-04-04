import 'package:attendance/models/nearby_location.dart';
import 'package:geolocator/geolocator.dart';

class UserPositionData {
  final Position userPosition;
  List<MarkerAttendence> listMarker;
  NearbyLocation nearby;
  String? locationName;
  String? qrError;

  UserPositionData({
    required this.userPosition,
    required this.listMarker,
    required this.nearby,
    this.locationName = '',
    this.qrError = ''
  });

  UserPositionData copyWith({
    Position? userPosition,
    List<MarkerAttendence>? listMarker,
    NearbyLocation? nearby,
    String? locationName,
    String? qrError
  }) {
    return UserPositionData(
      userPosition: userPosition ?? this.userPosition,
      listMarker: listMarker ?? this.listMarker,
      nearby: nearby ?? this.nearby,
      locationName: locationName ?? this.locationName,
      qrError: qrError ?? this.qrError,
    );
  }
}
