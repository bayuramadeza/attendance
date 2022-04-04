import 'package:attendance/app.dart';
import 'package:attendance/sevices/db/db_service.dart';
import 'package:flutter/material.dart';

late DbService database;

void main() {
  database = DbService();
  runApp(const MyApp());
}

