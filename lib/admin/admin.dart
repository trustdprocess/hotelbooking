import 'package:flutter/material.dart';
import 'package:new_app50/admin/drawer/addhotels.dart';
import 'package:new_app50/admin/drawer/hotelbooked.dart';
import 'package:new_app50/admin/drawer/analytics.dart';

class adminPanel extends StatefulWidget {
  const adminPanel({super.key});

  @override
  State<adminPanel> createState() => _adminPanelState();
}

class _adminPanelState extends State<adminPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin"),
        elevation: 0,
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        elevation: 0,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(""),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(Icons.bookmarks),
              title: Text("Hotel Booked"),
              onTap: () {
                                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => hotelbooked()));
              },
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(Icons.add_outlined),
              title: Text("Add Hotels"),
              onTap: () {
                                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => addhotels()));
              },
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(Icons.analytics),
              title: Text("Analytics"),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => AnalyticsPage()));
              },
            ),
          ],
        ),
      ),
      body: Center(child: Text("Welcome To Admin Panel!",style: TextStyle(fontSize: 20,),)),
    );
  }
}
