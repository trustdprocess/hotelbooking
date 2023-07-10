import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class detailPage extends StatelessWidget {
  final Map<String, dynamic> hotel;

  const detailPage({required this.hotel});

  @override
  Widget build(BuildContext context) {
    final List<String> imageUrls = List<String>.from(hotel['images']);

    return Scaffold(
      appBar: AppBar(
        title: Text('Quick Trips'),
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
                    height: 300,
                    width: 300,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Text('Hotel Name: ${hotel['hotelName']}'),
          Text('Owner Name: ${hotel['ownerName']}'),
          Text('Location: ${hotel['location']}'),
          Text('Price: Nrs ${hotel['price']}/night'),
            Text('Amenities:  ${hotel['amenities']}'),
              Text('trip:  ${hotel['tripType']}'),
                  Text('Location(Lat/Lon):  ${hotel['coordinates']}'),
            
        ],
      ),
    );
  }
}
