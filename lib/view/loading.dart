import 'package:flutter/material.dart';
import 'package:test_project/service/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Loading extends StatefulWidget {
  //const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  String location = 'Asia/Singapore'; // Initialize location with an empty string
  String country = 'Asia/Singapore'; // Initialize country with an empty string

  void setupWorldTime() async {
    // Delay for 3 seconds
    await Future.delayed(Duration(seconds: 3));

    WorldTime instance = WorldTime(location: location, flag: 'germany.png', country: country);
    await instance.getTime();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime,
    });
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    // Receive the arguments passed from the previous route (or null if none)
    Map<String, dynamic>? data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (data != null) {
      location = data['location'] ?? 'Asia/Singapore'; // Use the provided location or default to 'Asia/Singapore'
      country = data['country'] ?? 'Asia/Singapore'; // Use the provided country or default to 'Asia/Singapore'
    }

    return Scaffold(
      body: Center(
        child: SpinKitFoldingCube(
          color: Colors.blue,
          size: 100.0,
        ),
      ),
    );
  }
}