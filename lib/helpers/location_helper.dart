import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

const googleApiKey = 'AIzaSyAKr86zE-1EBt3VVh34dMe0nU77eBL3zVU';

class LocationHelper {
  static String generateLocationPreviewImage(
      {required double latitude, required double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$googleApiKey';
  }

  static Future<String> getPlaceAddress(double lat, double long) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$googleApiKey');

    final response = await http.get(url);
    return convert.jsonDecode(response.body)['results'][0]['formatted_address'];
  }
}
