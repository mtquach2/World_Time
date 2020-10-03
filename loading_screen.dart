import 'package:flutter/material.dart';
import 'package:worldtime/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setupWorldTime() async {
    WorldTime instance = WorldTime(location: 'Los Angeles', flag: 'los_angeles.png', url: 'America/Los_Angeles');
    await instance.getTime(); //waits until getTime() method is completed
    Navigator.pushReplacementNamed(context,'/home', arguments: {
      'Location' : instance.location,
      'Flag' : instance.flag,
      'Time' : instance.time,
      'isDaytime' : instance.isDaytime,
    });

  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
          child: SpinKitWave( //creates a loading screen with a wave effect
            color: Colors.white,
            size: 80.0,
          ),
      ),
    );
  }
}
