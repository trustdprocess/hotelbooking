import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';

import '../googlemap/googlemap.dart';

import '../googlemap/map.dart';
import '../homepage/home.dart';


class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  bool _animationPlayed = false;

  @override
  void initState() {
    super.initState();
    if (!_animationPlayed) {
      Future.delayed(Duration(seconds: 3)).then((value) {
        setState(() {
          _animationPlayed = true;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => MapSample()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_animationPlayed) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => homepage()),
          );
        }
        return true;
      },
      child: Scaffold(
        body: _animationPlayed
            ? MapSample()
            : Center(
                child: Container(
                  height: 200,
                  width: 200,
                  child: Lottie.asset("Animations/animation1.json"),
                ),
              ),
      ),
    );
  }
}
