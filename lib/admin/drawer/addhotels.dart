import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_app50/ourservices/trips.dart';
import 'package:path/path.dart' as path;

class addhotels extends StatefulWidget {
  const addhotels({Key? key}) : super(key: key);

  @override
  State<addhotels> createState() => _addhotelsState();
}

class _addhotelsState extends State<addhotels> {
  final formKey = GlobalKey<FormState>();
  List<File?> _images = List.generate(4, (_) => null);
  List<String> _selectedAmenities = [];
  final TextEditingController _hotelNameController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _contactNoController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _coordinatesController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _tripTypeController = TextEditingController();

  Future getImage(int index) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      _images[index] = imageTemporary;
    });
  }

  void toggleAmenity(String amenity) {
    setState(() {
      if (_selectedAmenities.contains(amenity)) {
        _selectedAmenities.remove(amenity);
      } else {
        _selectedAmenities.add(amenity);
      }
    });
  }
void navigateToTripsPage() async {
  if (formKey.currentState!.validate()) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Processing Data!")),
    );

    // Upload images to Firebase Storage
    List<String> imageUrls = await uploadImagesToFirebaseStorage();

    // Create a new document in the "hotels" collection
    await FirebaseFirestore.instance.collection("hotels").add({
      "hotelName": _hotelNameController.text,
      "ownerName": _ownerNameController.text,
      "contactNo": _contactNoController.text,
      "location": _locationController.text,
      "coordinates": _coordinatesController.text,
      "price": _priceController.text,
      "tripType": _tripTypeController.text,
      "amenities": _selectedAmenities,
      "images": imageUrls,
    });

    // Navigate to the Trips page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => trips()),
    );
  }
}


Future<List<String>> uploadImagesToFirebaseStorage() async {
  List<String> imageUrls = [];

  try {
    for (File? image in _images) {
      if (image != null) {
        // Generate a unique file name
        String fileName = DateTime.now().millisecondsSinceEpoch.toString() +
            path.basename(image.path);

        // Upload the image to Firebase Storage
        Reference ref =
            FirebaseStorage.instance.ref().child("images/$fileName");
        UploadTask uploadTask = ref.putFile(image);
        TaskSnapshot taskSnapshot = await uploadTask;

        // Get the download URL of the uploaded image
        String imageUrl = await taskSnapshot.ref.getDownloadURL();

        // Add the download URL to the list
        imageUrls.add(imageUrl);
      }
    }
  } catch (e) {
    // Handle upload errors
    print("Error uploading images: $e");
  }

  return imageUrls;
}




  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Hotels"),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 0; i < _images.length; i++)
                      GestureDetector(
                        onTap: () => getImage(i),
                        child: Container(
                          width: 250,
                          height: 250,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          child: _images[i] != null
                              ? Image.file(
                                  _images[i]!,
                                  height: 250,
                                  width: 250,
                                  fit: BoxFit.fill,
                                )
                              : Image.network(
                                  "https://t4.ftcdn.net/jpg/04/99/93/31/360_F_499933117_ZAUBfv3P1HEOsZDrnkbNCt4jc3AodArl.jpg",
                                  height: 250,
                                  width: 250,
                                ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: CustomButton(
                  title: "Pick From Gallery",
                  icon: Icons.photo,
                  onClick: () => getImage(0),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                title: "Hotel Name",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "You Cannot Leave This Field Empty";
                  }
                },
              ),
              TextField(title: "Owner's Name",
              validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "You Cannot Leave This Field Empty";
                  }
                },),
              TextField(title: "Contact no",
              validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "You Cannot Leave This Field Empty";
                  }
                },),
              TextField(title: "Location(District/City/Street-no)",validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "You Cannot Leave This Field Empty";
                  }
                },),
              TextField(title: "Location(latitude,longitude)",validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "You Cannot Leave This Field Empty";
                  }
                },),
              TextField(title: "Price",validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "You Cannot Leave This Field Empty";
                  }
                },),
              TextField(
                title: "Quick Trip/Family Trip",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "You Cannot Leave This Field Empty";
                  }
                },
              ),
            
              SizedBox(height: 20),
              Text(
                "Amenities",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  CheckboxListTile(
                    title: Text("Swimming Pool"),
                    value: _selectedAmenities.contains("Swimming Pool"),
                    onChanged: (value) => toggleAmenity("Swimming Pool"),
                  ),
                  CheckboxListTile(
                    title: Text("Gym"),
                    value: _selectedAmenities.contains("Gym"),
                    onChanged: (value) => toggleAmenity("Gym"),
                  ),
                  CheckboxListTile(
                    title: Text("Restaurant"),
                    value: _selectedAmenities.contains("Restaurant"),
                    onChanged: (value) => toggleAmenity("Restaurant"),
                  ),
                  CheckboxListTile(
                    title: Text("Sauna"),
                    value: _selectedAmenities.contains("Sauna"),
                    onChanged: (value) => toggleAmenity("Sauna"),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Selected Amenities",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  for (String amenity in _selectedAmenities)
                    ListTile(
                      title: Text(amenity),
                    ),
                ],
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Processing Data!")),
                    );
                  }
                },
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      "Add Hotel",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onClick;

  const CustomButton({
    required this.title,
    required this.icon,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: ElevatedButton(
        
        child: Row(
          children: [
            Icon(icon),
            SizedBox(
              width: 10,
            ),
            Text(title),
          ],
        ),
        onPressed: onClick,
      ),
    );
  }
}

class TextField extends StatelessWidget {
  final String title;
  final String? Function(String?)? validator;
  const TextField({required this.title, required this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        decoration: InputDecoration(hintText: title),
        validator: validator,
      ),
    );
  }
}
