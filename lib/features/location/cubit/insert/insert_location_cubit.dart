import 'package:attendance/sevices/repositories/location_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'insert_location_state.dart';

class InsertLocationCubit extends Cubit<InsertLocationState> {
  final LocationRepository _repository;
  InsertLocationCubit(this._repository) : super(InsertLocationInitial());

  request(String name, double latitude, double longitude)async{
    emit(InsertLocationLoading());
    try{
      await _repository.insertLocation(name, latitude, longitude);
      emit(InsertLocationLoaded());
    } catch(e){
      emit(InsertLocationError(e.toString()));
    }
  }
}
