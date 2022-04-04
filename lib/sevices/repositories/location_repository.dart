import 'package:attendance/main.dart';
import 'package:attendance/sevices/db/db_service.dart';

abstract class LocationRepository{
  Future<List<LocationTable>> getLocations();
  Future<dynamic> insertLocation(String name, double latitude, double longitude);
  Future<dynamic> deleteLocation(LocationTable location);
}

class LocationRepositoryImpl implements LocationRepository{
  @override
  Future<List<LocationTable>> getLocations() async{
    try{
      final locations = await database.getAllLocation();
      return locations;
    } catch(e){
      rethrow;
    }
  }

  @override
  Future insertLocation(String name, double latitude, double longitude) async{
    try{
      return await database.insertLocation([LocationTable(name: name, latitide: latitude, longitude: longitude)]);
    } catch(e){
      rethrow;
    }
  }

  @override
  Future deleteLocation(LocationTable location) async{
    return await database.deleteLocation(location.name);
  }
}