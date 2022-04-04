part of 'get_location_cubit.dart';

abstract class GetLocationState extends Equatable {
  const GetLocationState();

  @override
  List<Object> get props => [];
}

class GetLocationLoading extends GetLocationState {}
class GetLocationLoaded extends GetLocationState {
  final List<LocationTable> locations;

  const GetLocationLoaded(this.locations);
}

class GetLocationError extends GetLocationState {
  final String message;

  const GetLocationError(this.message);
}
