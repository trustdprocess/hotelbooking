import 'package:flutter/material.dart';
class vacation extends StatefulWidget {
  const vacation({super.key});

  @override
  State<vacation> createState() => _vacationState();
}

class _vacationState extends State<vacation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Family Vacation"),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}