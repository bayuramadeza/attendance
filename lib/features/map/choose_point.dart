import 'package:attendance/features/map/cubit/map_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class ChoosePoint extends StatefulWidget {
  static const route = '/map';

  const ChoosePoint({Key? key}) : super(key: key);
  @override
  State<ChoosePoint> createState() => ChoosePointState();
}

class ChoosePointState extends State<ChoosePoint> {
  final Completer<GoogleMapController> _controller = Completer();
  late MapCubit _mapCubit;
  String street = 'Long Tap at a point to choose location';

  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(-6.200000, 106.816666),
    zoom: 19.151926040649414,
  );

  @override
  void initState() {
    _mapCubit = BlocProvider.of<MapCubit>(context)..getCurrentPositionUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        final Set<Marker> _markers = {};
        if (state is MapLoaded) {
          if (state.location.marker != null) {
            _markers
              ..clear()
              ..add(state.location.marker!);
          }
          moveCamera(state.location.camera!);
        }
        if (state is MapLoaded) street = state.location.street ?? '';
        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Choose a point"),
                Text('Hold for one second on your designated location', style: TextStyle(fontSize: 11),)
              ],
            ),
            actions: [
              TextButton(
                child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.check, color: Colors.white)),
                onPressed: () => Navigator.pop(
                    context, (state is MapLoaded) ? state.location : null),
              )
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GoogleMap(
                  onLongPress: (loc) {
                    _mapCubit.setLocation(loc.latitude, loc.longitude);
                  },
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: _markers,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: MediaQuery.of(context).size.width / 1.25,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Dropped pin',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      street,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8)
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: () => _mapCubit.getCurrentPositionUser(),
            child: const Icon(
              Icons.location_searching,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  Future<void> moveCamera(CameraPosition position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(position));
  }
}
