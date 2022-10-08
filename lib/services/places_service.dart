import 'package:fmd_app/models/place_search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesService {
  Future<List<PlaceSearch>> getAutoComplete(String search) async {
    final key = 'AIzaSyA51RJ9xuTmgvU_bqHxdz36npyeSbfmTeo';
    var url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=%28cities%29&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }
}
