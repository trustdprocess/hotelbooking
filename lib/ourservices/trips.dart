import 'package:flutter/material.dart';
class trips extends StatefulWidget {
  const trips({super.key});

  @override
  State<trips> createState() => _tripsState();
}

class _tripsState extends State<trips> {
  @override
  Widget build(BuildContext context) {
    return  AppBar(
title: Text("Quick Trips"),
backgroundColor: Colors.transparent,
    );
  }
}