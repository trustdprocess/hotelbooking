import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_app50/googlemap/search.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class MapSample extends StatefulWidget {
  const MapSample({Key? key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(27.7172, 85.3240),
    zoom: 14.4746,
  );

  TextEditingController _text = TextEditingController();
  List<Marker> _marker = [];
  List<Marker> _list = [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(27.7172, 85.3240),
      infoWindow: InfoWindow(title: "My Location"),
    ),
    Marker(
      markerId: MarkerId('2'),
      position: LatLng(27.7101, 85.3252),
      infoWindow: InfoWindow(title: "My Location"),
    ),
  ];
  var uuid = Uuid();
  String _sessionToken = "1234";
  List<dynamic> _placeList = [];
  LatLng _markerCoordinates = LatLng(0, 0); // Added line

  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
    _text.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_text.text);
  }

  getSuggestion(String input) async {
    String kPLACES_API_KEY = "AIzaSyBl6ol7bJnQsEa-qlzhuInQ5OEZe2AI3Io";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
    var response = await http.get(Uri.parse(request));
    print(response.body.toString());
    if (response.statusCode == 200) {
      setState(() {
        _placeList = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception("Unable To Fetch Data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search"),elevation: 0,),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _text,
                  decoration: InputDecoration(
                    hintText: "Search Location",
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Search().getPlaceId(_text.text);
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: Set<Marker>.of([
                Marker(
                  markerId: MarkerId('hotel'),
                  position: _markerCoordinates,
                ),
              ]),
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          currentLocation().then((Position position) {
            _controller.future.then((GoogleMapController controller) {
              controller.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 15,
                ),
              ));
            });
          });
        },
        child: Icon(Icons.location_on_sharp),
      ),
    );
  }

  Future<Position> currentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled');
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      print(
          'Location permissions are permanently denied, we cannot request permissions.');
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        print('Location permissions are denied (actual value: $permission).');
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition();
  }
}
