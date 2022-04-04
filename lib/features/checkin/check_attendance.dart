import 'package:attendance/features/checkin/cubit/check/checkin_cubit.dart';
import 'package:attendance/models/user_position_data.dart';
import 'package:attendance/utils/position.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CheckIn extends StatefulWidget {
  static const route = '/check-in';
  final String title;
  const CheckIn({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _CheckInState createState() => _CheckInState();
}

const zoom = 17.0;

class _CheckInState extends State<CheckIn> {
  final Completer<GoogleMapController> _controller = Completer();
  late Position? position;

  final CameraPosition _initialCamera = const CameraPosition(
    target: LatLng(-6.200000, 106.816666),
    zoom: zoom,
  );

  @override
  void initState() {
    BlocProvider.of<CheckinCubit>(context).getLocation();
    super.initState();
  }

  Future<void> _goToPosition() async {
    Position userPosition = await determinePosition();
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(userPosition.latitude, userPosition.longitude),
      zoom: zoom,
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.title,),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 8,
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            onPressed: () => BlocProvider.of<CheckinCubit>(context).checkIn(),
            child: Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: BlocConsumer<CheckinCubit, CheckinState>(
        listener: (context, state) {
          if (state is CheckinLoaded) {
            _goToPosition();
          } else if(state is CheckinChecked){
            showDialog(
              context: context, 
              builder: (context){
                return AlertDialog(
                  title: Text('${widget.title} Success'),
                  actions: [
                    ElevatedButton(onPressed: (){
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }, child: const Text('OK'))
                  ],
                );
              }
            );
          } else if(state is CheckinError){
            showDialog(
              context: context, 
              builder: (context){
                return AlertDialog(
                  title: Text('${widget.title} Failed'),
                  content: Text(state.message),
                  actions: [
                    ElevatedButton(onPressed: (){
                      Navigator.pop(context);                    
                    }, child: const Text('OK'))
                  ],
                );
              }
            );
          }
        },
        builder: (context, state) {
          Set<Marker> _markers = {};
          Iterable _circles = [];
          UserPositionData? userPositionData;
          if(state is CheckinLoaded){
            userPositionData = state.userPosition;
            
          } else if(state is CheckinError){
            userPositionData = state.userPosition;
          } else if(state is CheckinLoading){
            userPositionData = state.userPosition;
          }
          if(userPositionData!=null){
            _circles = Iterable.generate(userPositionData.listMarker.length, (index) {
              _markers.add(userPositionData!.listMarker[index].marker);
              return userPositionData.listMarker[index].circle;
            });
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: GoogleMap(
                myLocationEnabled: true,
                markers: _markers,
                circles: Set.from(_circles),
                initialCameraPosition: _initialCamera,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
