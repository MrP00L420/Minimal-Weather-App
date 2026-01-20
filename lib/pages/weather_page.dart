import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myapp/model/weather_model.dart';
import 'package:myapp/services/weather_service.dart';
import 'package:lottie/lottie.dart';

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
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json'; //default

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'haze':
      case 'fog':
      case 'dust':
        return 'assets/windy.json';
      case 'rain':
        return 'assets/rainy.json';
      case 'drizzle':
      case 'shower rain':
        return 'assets/partly_shower.json';
      case 'thunderstorm':
        return 'assets/storm.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

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
        child: _weather == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //CityName
                  Text(
                    _weather!.cityName,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  //Animation
                  Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

                  //Temperature
                  Text(
                    '${_weather!.temperature.round()} °C',
                    style: const TextStyle(fontSize: 60),
                  ),

                  //Weather Condition
                  Text(
                    _weather?.mainCondition ?? '',
                    style: const TextStyle(fontSize: 60),
                  ),
                ],
              ),
      ),
    );
  }
}
