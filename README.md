# Weather App

A simple Flutter application that displays the current weather for the user's location.

## Features

*   Fetches the user's current city using the `geolocator` and `geocoding` packages.
*   Retrieves real-time weather data from the OpenWeatherMap API.
*   Displays the city name and temperature.

## Getting Started

### Prerequisites

*   Flutter SDK: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
*   A code editor like Visual Studio Code or Android Studio.
*   An API key from OpenWeatherMap: [https://openweathermap.org/api](https://openweathermap.org/api)

### Installation

1.  Clone the repository:

    ```bash
    git clone https://github.com/MrP00L420/weather-app.git
    ```

2.  Install the dependencies:

    ```bash
    flutter pub get
    ```

3.  Create a `.env` file in the root of the project and add your OpenWeatherMap API key:

    ```
    API_KEY=YOUR_API_KEY
    ```

4.  Run the app:

    ```bash
    flutter run
    ```

## Dependencies

*   `flutter`
*   `http`
*   `geolocator`
*   `geocoding`
*   `flutter_dotenv`
*   `lottie`

