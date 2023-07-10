import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_app50/ourservices/detailpage.dart';

class trips extends StatefulWidget {
  const trips({Key? key}) : super(key: key);

  @override
  State<trips> createState() => _tripsState();
}

class _tripsState extends State<trips> {
  late Stream _hotelsStream;

  @override
  void initState() {
    super.initState();
    _hotelsStream = FirebaseFirestore.instance.collection('hotels').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quick Trips'),
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder(
        stream: _hotelsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final hotels = snapshot.data!.docs;

          return ListView.builder(
            itemCount: hotels.length,
            itemBuilder: (context, index) {
              final hotel = hotels[index].data() as Map<String, dynamic>;

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => detailPage(hotel: hotel),
                    ),
                  );
                },
                child: Card(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: 200,
                        height: 250,
                        child: Image.network(
                          hotel['images'][0],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Name: ${hotel['hotelName']}',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(height: 10),
                              Text(
                                ' Location: ${hotel['location']}',
                                style: TextStyle(fontSize: 15),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Price: Nrs ${hotel['price']}/night',
                                style: TextStyle(fontSize: 15),
                              ),
                              SizedBox(height: 10),
                              Text('Contact No: ${hotel['contactNo']}'),
                              SizedBox(height: 10),
                              Container(
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => detailPage(hotel: hotel),
                                      ),
                                    );
                                  },
                                  child: Text("See More"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
