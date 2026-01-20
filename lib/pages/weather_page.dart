import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myapp/model/weather_model.dart';
import 'package:myapp/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // Api Key
  final _weatherService = WeatherService(dotenv.env['API_KEY']!);

  Weather? _weather;

  // Get Weather Data
  Future<void> _fetchWeather() async {
    try {
      // Get current city
      String cityName = await _weatherService.getCurrentCity();

      // Fetch weather data for the city
      final weather = await _weatherService.fetchWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print('Error fetching weather: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  // Animation

  //intialize state
  @override
  void initState() {
    super.initState();
    //Fetch weather data when the page loads
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //CityName
            Text(
              _weather?.cityName ?? 'Loading City ...',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),

            //Temperature
            Text(
              _weather != null ? '${_weather!.temperature.round()} °C' : '',
              style: const TextStyle(fontSize: 80),
            ),
          ],
        ),
      ),
    );
  }
}
