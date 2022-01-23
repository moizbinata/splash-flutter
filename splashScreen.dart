import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:udhaivihealthcare/utils/constants.dart';
import 'package:udhaivihealthcare/utils/size_config.dart';
import 'package:udhaivihealthcare/views/home.dart';
import 'package:udhaivihealthcare/views/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  GetStorage box = GetStorage();
  AnimationController controller;
  Animation<double> animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.repeat();
    startTime();
  }

  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              (box.read('userProfile') != null) ? Home() : Login(),
        ));
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.all(20),
        color: Colors.grey.shade300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(''),
            Image.asset(
              'assets/img/udhaivi.png',
              width: SizeConfig.heightMultiplier * 35,
              height: SizeConfig.heightMultiplier * 35,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              // width: 300,
              height: 15,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.white,
                  color: Constants.primaryColor,
                  value: animation.value,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
