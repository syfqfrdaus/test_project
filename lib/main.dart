import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/view/choose_location.dart';
import 'package:test_project/view/home.dart';
import 'package:test_project/view/loading.dart';

void main() => runApp(GetMaterialApp(
  debugShowCheckedModeBanner: false,

  initialRoute: '/',
  routes: {
    '/': (context) => Loading(),
    '/home': (context) => Home(),
    '/location': (context) => ChooseLocation(),

  },
));