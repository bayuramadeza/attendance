import 'package:attendance/features/location/cubit/insert/insert_location_cubit.dart';
import 'package:attendance/features/location/cubit/location/get_location_cubit.dart';
import 'package:attendance/features/map/choose_point.dart';
import 'package:attendance/features/map/cubit/map_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationScreen extends StatefulWidget {
  static const route = 'location';
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData(){
    BlocProvider.of<GetLocationCubit>(context).request();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InsertLocationCubit, InsertLocationState>(
      builder: (context, state) {
        // bool isLoading = state is InsertLocationLoading;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Locations'),
            actions: [
              IconButton(
                  onPressed: () async {
                    final result =
                        await Navigator.pushNamed(context, ChoosePoint.route);
                    if (result != null) {
                      final location = result as MapWithLocationName;
                      context.read<InsertLocationCubit>().request(location.street??'', location.latitude!, location.longitude!);
                      getData();
                    }
                  },
                  icon: const Icon(Icons.add))
            ],
          ),
          body: BlocBuilder<GetLocationCubit, GetLocationState>(
            builder: (context, state) {
              return state is GetLocationLoaded
                  ? state.locations.isEmpty? const Center(
                    child: Text('Data lokasi attendance belum tersedia'),
                  ) : ListView.builder(
                      itemCount: state.locations.length,
                      itemBuilder: (BuildContext context, int index) {
                        final loc = state.locations[index];
                        return Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey))),
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              Expanded(child: Text(loc.name)),
                              GestureDetector(
                                onTap: ()=>context.read<GetLocationCubit>().delete(loc),
                                child: const Icon(Icons.delete, color: Colors.grey,)
                              )
                            ],
                          ),
                        );
                      },
                    )
                  : state is GetLocationError
                      ? Center(
                          child: Text(state.message),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
            },
          ),
        );
      },
    );
  }
}
