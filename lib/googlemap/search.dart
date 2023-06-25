import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Search {
  final String key = 'AIzaSyBl6ol7bJnQsEa-qlzhuInQ5OEZe2AI3Io';

  Future<String> getPlaceId(String input) async {
  final String url =
      'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key';
  var response = await http.get(Uri.parse(url));
  var json = convert.jsonDecode(response.body);
  
  if (json['candidates'] != null && json['candidates'].length > 0) {
    var placeId = json['candidates'][0]['place_id'] as String;
    print(placeId);
    return placeId;
  } else {
    throw Exception('No candidates found');
  }
}


   
}
