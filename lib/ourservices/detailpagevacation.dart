import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_app50/ourservices/vacation.dart';
import 'package:new_app50/userform/userform.dart';

class vacationDetail extends StatelessWidget {
  final Map<String, dynamic> vacations;

  const vacationDetail({required this.vacations});

  @override
  Widget build(BuildContext context) {
    final List<String> imageUrls = List<String>.from(vacations['images']);

    return Scaffold(
      appBar: AppBar(
        title: Text('Vacation Trips'),
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                final imageUrl = imageUrls[index];
                return Container(
                  width: 250,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 500,
                    width: 600,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Text('Hotel Name: ${vacations['hotelName']}'),
          Text('Owner Name: ${vacations['ownerName']}'),
          Text('Location: ${vacations['location']}'),
          Text('Price: Nrs ${vacations['price']}/night'),
          Text('Amenities:  ${vacations['amenities']}'),
          Text('trip:  ${vacations['tripType']}'),
          Text('Location(Lat/Lon):  ${vacations['coordinates']}'),
          Text('Description:${vacations['Description']}'),
          InkWell(
            child: Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(16)),
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Book Now",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  )),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => userForm()));
            },
          )
        ],
      ),
    );
  }
}
