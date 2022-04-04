import 'package:google_maps_flutter/google_maps_flutter.dart';

class NearbyLocation {
  final MarkerAttendence markerAttendence;
  final bool isInsideRadius;
  final double range;
  final double latitude;
  final double longitude;
  final double radius;

  NearbyLocation({
    required this.markerAttendence,
    required this.isInsideRadius,
    required this.range,
    required this.latitude,
    required this.longitude,
    required this.radius,
  });

  @override
  String toString() =>
      'NearbyLocation(markerAttendence: $markerAttendence, isInsideRadius: $isInsideRadius, range: $range)';

  NearbyLocation copyWith({
    MarkerAttendence? markerAttendence,
    bool? isInsideRadius,
    double? range,
    double? latitude,
    double? longitude,
    double? radius,
  }) {
    return NearbyLocation(
      markerAttendence: markerAttendence ?? this.markerAttendence,
      isInsideRadius: isInsideRadius ?? this.isInsideRadius,
      range: range ?? this.range,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      radius: radius ?? this.radius,
    );
  }
}

class MarkerAttendence {
  final Circle circle;
  final Marker marker;
  final String locationName;

  MarkerAttendence({
    required this.circle,
    required this.marker,
    required this.locationName,
  });
}
