import 'dart:io';

import 'package:attendance/features/checkin/check_attendance.dart';
import 'package:attendance/features/checkin/cubit/check/checkin_cubit.dart';
import 'package:attendance/features/home/home.dart';
import 'package:attendance/features/location/cubit/insert/insert_location_cubit.dart';
import 'package:attendance/features/location/cubit/location/get_location_cubit.dart';
import 'package:attendance/features/location/location.dart';
import 'package:attendance/features/map/choose_point.dart';
import 'package:attendance/features/map/cubit/map_cubit.dart';
import 'package:attendance/routes/page_routes.dart';
import 'package:attendance/sevices/repositories/location_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    transition({required Widget child, required RouteSettings settings}) {
      return Platform.isIOS
          ? MaterialPageRoute(
              settings: settings,
              builder: (context) {
                return child;
              },
            )
          : PageRoutes(settings: settings, child: child);
    }

    switch (settings.name) {
      case HomeScreen.route:
        return transition(
          settings: settings,
          child: const HomeScreen(),
        );
      case ChoosePoint.route:
        return transition(
          settings: settings,
          child: BlocProvider<MapCubit>(
            create: (context) => MapCubit(),
            child: const ChoosePoint(),
          ),
        );
      case LocationScreen.route:
        return transition(
          settings: settings,
          child: MultiBlocProvider(
            providers: [
              BlocProvider<InsertLocationCubit>(
                create: (context) => InsertLocationCubit(LocationRepositoryImpl()),
              ),
              BlocProvider<GetLocationCubit>(
                create: (context) => GetLocationCubit(LocationRepositoryImpl()),
              ),
            ],
            child: const LocationScreen(),
          )
        );
      case CheckIn.route:
        return transition(
          settings: settings,
          child: MultiBlocProvider(
            providers: [
              BlocProvider<CheckinCubit>(
                create: (context) => CheckinCubit(LocationRepositoryImpl()),
              ),
            ],
            child: CheckIn(title: arguments as String,),
          )
        );
      default:
        return transition(
          settings: settings,
          child: Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
