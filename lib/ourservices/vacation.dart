import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_app50/ourservices/detailpage.dart';
import 'package:new_app50/ourservices/detailpagevacation.dart';

class vacation extends StatefulWidget {
  const vacation({Key? key}) : super(key: key);

  @override
  State<vacation> createState() => _vacationState();
}

class _vacationState extends State<vacation> {
  late Stream _hotelsStream;

  @override
  void initState() {
    super.initState();
    _hotelsStream = FirebaseFirestore.instance.collection('vacations').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vacation'),
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

          final vacation = snapshot.data!.docs;//list of hotels return

          return ListView.builder(
            itemCount: vacation.length,
            itemBuilder: (context, index) {
              final vacations = vacation[index].data() as Map<String, dynamic>;//certain hotel index return

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => vacationDetail()));
                },
                child: Card(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        width: 200,
                        height: 250,
                        child: Image.network(
                          vacations['images'][0],
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
                                'Name: ${vacations['hotelName']}',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(height: 10),
                              Text(
                                ' Location: ${vacations['location']}',
                                style: TextStyle(fontSize: 15),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                'Price:Nrs ${vacations['price']}/night',
                                style: TextStyle(fontSize: 15),
                              ),
                                  SizedBox(height: 10),
                              Text('Contact No:${vacations['contactNo']}'),
                              SizedBox(height: 10),
                                Container(
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => vacationDetail()));
                                    },
                                    child: Text("See More")),
                              )
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
