import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_app50/userform/userform.dart';

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
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FullScreenImage(imageUrl: imageUrl),
                      ),
                    );
                  },
                  child: Hero(
                    tag: imageUrl,
                    child: Container(
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
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
              SizedBox(height: 20),
        Row(
          children: [
              Expanded(
                child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Hotel Name: ${hotel['hotelName']}',
                    style: TextStyle(fontSize: 18),
                  )),
                        ),
              ),
          SizedBox(
            height: 0,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Text('Owner Name: ${hotel['ownerName']}',style: TextStyle(fontSize: 12),)),
            ),
          ),
          ],
        ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              alignment: Alignment.bottomLeft,
              child: Text('Location: ${hotel['location']}',style: TextStyle(fontSize: 15),)),
          ),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(child: Text('Price: Nrs ${hotel['price']}/night')),
          ),
          Text('Amenities:  ${hotel['amenities']}'),
          Text('trip:  ${hotel['tripType']}'),
          Text('Location(Lat/Lon):  ${hotel['coordinates']}'),
          Text('Description:${hotel['Description']}'),
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
        
   

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Center(
        child: Hero(
          tag: imageUrl,
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}