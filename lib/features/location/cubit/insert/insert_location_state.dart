part of 'insert_location_cubit.dart';

abstract class InsertLocationState extends Equatable {
  const InsertLocationState();

  @override
  List<Object> get props => [];
}

class InsertLocationInitial extends InsertLocationState {}

class InsertLocationLoading extends InsertLocationState {}

class InsertLocationLoaded extends InsertLocationState {}

class InsertLocationError extends InsertLocationState {
  final String message;

  const InsertLocationError(this.message);
}
