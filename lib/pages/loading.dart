import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:world_time/services/world_time.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  void setupWorldTime() async{
    WorldTime worldTime = WorldTime(location: 'Australia%2FBrisbane', flag: 'au.png', url: 'Australia%2FBrisbane');
    await worldTime.getTime();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': worldTime.location,
      'flag': worldTime.flag,
      'time': worldTime.time,
      'isDaytime': worldTime.isDaytime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SpinKitWanderingCubes(
          color: Colors.blue,
          size: 50.0,
        ),
      ),
    );
  }
}
