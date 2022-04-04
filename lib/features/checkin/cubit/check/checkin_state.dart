part of 'checkin_cubit.dart';

abstract class CheckinState extends Equatable {
  const CheckinState();

  @override
  List<Object> get props => [];
}

class CheckinInitial extends CheckinState {}
class CheckinLoading extends CheckinState {
  final UserPositionData? userPosition;

  const CheckinLoading({this.userPosition});
}
class CheckinChecked extends CheckinState {}
class CheckinLoaded extends CheckinState {
  final UserPositionData userPosition;

  const CheckinLoaded(this.userPosition);
}
class CheckinError extends CheckinState {
  final String message;
  final UserPositionData? userPosition;

  const CheckinError(this.message, {this.userPosition});
}
