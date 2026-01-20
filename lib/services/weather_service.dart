import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../model/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASEURL = 'https://api.openweathermap.org/data/2.5/weather';

  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather?> fetchWeather(String cityName) async {
    final url = Uri.parse('$BASEURL?q=$cityName&appid=$apiKey&units=metric');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = response.body;
      final weatherData = Weather.fromJson(jsonDecode(json));
      return weatherData;
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentCity() async {
    // Get permission from user
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permission is permanently denied');
    }

    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      throw Exception('Location permission not granted');
    }

    // Fetch current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Get City name from coordinates
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    // Return the city name
    String city = placemarks[0].locality ?? "Unknown";

    return city;
  }
}
