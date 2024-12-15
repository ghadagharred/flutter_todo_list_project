import 'package:flutter/material.dart';
import 'package:flutter_application_1/homepage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  //sqfliteFfiInit();
  // databaseFactory = databaseFactoryFfi;
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Homepage()));
}
