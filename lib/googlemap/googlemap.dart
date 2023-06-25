// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:new_app50/homepage/home.dart';
// import 'package:new_app50/googlemap/search.dart';

// class MapSample extends StatefulWidget {
//   const MapSample({Key? key}) : super(key: key);

//   @override
//   State<MapSample> createState() => MapSampleState();
// }

// class MapSampleState extends State<MapSample> {
//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();
//   late FocusNode _searchFocusNode;

//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );

//   final Set<Marker> _markers = {};
//   TextEditingController _text = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _searchFocusNode = FocusNode();
//   }

//   @override
//   void dispose() {
//     _searchFocusNode.dispose();
//     super.dispose();
//   }

//   void _performSearch() async {
//     final searchInstance = Search();
//     await searchInstance.getPlaceId(_text.text);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               GoogleMap(
//                 mapType: MapType.normal,
//                 initialCameraPosition: _kGooglePlex,
//                 onMapCreated: (GoogleMapController controller) {
//                   if (!_controller.isCompleted) {
//                     _controller.complete(controller);
//                     _addMarker();
//                   }
//                 },
//                 markers: _markers,

//               ),
//             ],
//           ),
//           Positioned(
//             top: kToolbarHeight,
//             left: 16.0,
//             right: 16.0,
//             child: Container(
//               padding: EdgeInsets.symmetric(vertical: 8.0),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(26),
//               ),
//               child: TextFormField(
//                 controller: _text,
//                 textCapitalization: TextCapitalization.characters,
//                 focusNode: _searchFocusNode,
//                 decoration: InputDecoration(
//                   hintText: 'Search Location',
//                   prefixIcon: Icon(
//                     Icons.location_on,
//                     color: Colors.red,
//                   ),
//                   suffixIcon: IconButton(
//                     onPressed: _performSearch,
//                     icon: Icon(Icons.search),
//                   ),
//                   border: InputBorder.none,
//                 ),
//                 onChanged: (value) {
//                   print(value);
//                 },
//               ),
//             ),
//           ),
          
//         ],
//       ),
//     );
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       FocusScope.of(context).requestFocus(_searchFocusNode);
//     });
//   }

//   void _addMarker() {
//     setState(() {
//       _markers.add(
//         Marker(
//           markerId: MarkerId('_Marker'),
//           infoWindow: InfoWindow(title: 'Google Plexs'),
//           icon: BitmapDescriptor.defaultMarker,
//           position: LatLng(37.42796133580664, -122.085749655962),
//         ),
//       );
//     });
//   }


// Future<Position> currentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       print('Location services are disabled');
//       return Future.error('Location services are disabled');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.deniedForever) {
//       print(
//           'Location permissions are permanently denied, we cannot request permissions.');
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission != LocationPermission.whileInUse &&
//           permission != LocationPermission.always) {
//         print('Location permissions are denied (actual value: $permission).');
//         return Future.error(
//             'Location permissions are denied (actual value: $permission).');
//       }
//     }

//     return await Geolocator.getCurrentPosition();
//   }
//  }
