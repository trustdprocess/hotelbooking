import 'package:flutter/material.dart';
class adminPanel extends StatefulWidget {
  const adminPanel({super.key});

  @override
  State<adminPanel> createState() => _adminPanelState();
}

class _adminPanelState extends State<adminPanel> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
   appBar: AppBar(title: Text("Admin"),
   elevation: 0,
   
   ),
 drawer: Drawer(
  
  backgroundColor: Colors.white,
  elevation: 0,
  
 ),
    );
  }
}