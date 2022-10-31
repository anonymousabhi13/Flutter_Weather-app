import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wther_app/modal/weatherModal.dart';

class weatherapiClient {
  Future<Weather>? getCurrentWeather(String? location) async {
    var endpoint = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=9a5b32e446a3b68735515e0fb390fd25&units=metric");

    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    print(Weather.fromJson(body).cityName);
    return Weather.fromJson(body);
  }
}
