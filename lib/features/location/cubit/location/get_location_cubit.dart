import 'package:attendance/sevices/db/db_service.dart';
import 'package:attendance/sevices/repositories/location_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_location_state.dart';

class GetLocationCubit extends Cubit<GetLocationState> {
  final LocationRepository _repository;
  GetLocationCubit(this._repository) : super(GetLocationLoading());

  request()async{
    emit(GetLocationLoading());
    try{
      final result = await _repository.getLocations();
      emit(GetLocationLoaded(result));
    } catch(e){
      emit(GetLocationError(e.toString()));
    }
  }

  delete(LocationTable location)async{
    try{
      await _repository.deleteLocation(location);
      emit(GetLocationLoading());
      final result = await _repository.getLocations();
      emit(GetLocationLoaded(result));
    } catch(e){
      emit(GetLocationError(e.toString()));
    }
  }
}
