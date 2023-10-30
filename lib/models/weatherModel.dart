import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class WeatherData extends ChangeNotifier {
  String? areaName;
  String? country;
  double? tempMax;
  double? tempMin;
  String? weatherDescription;
  String? weatherIcon;
  double? tempFeelsLike;
  List<Weather>? forecast; // Liste des prévisions

  WeatherData({
    this.areaName,
    this.country,
    this.tempMax,
    this.tempMin,
    this.weatherDescription,
    this.weatherIcon,
    this.tempFeelsLike,
    this.forecast, // Initialisez la liste des prévisions
  });

  Future<WeatherData> fetchWeatherData(String cityName) async {
    const apiKey =
        "cd820212af00e720a383783dbb7a591a"; // Remplacez par votre clé d'API
    final weatherFactory = WeatherFactory(apiKey, language: Language.FRENCH);

    try {
      final w = await weatherFactory.currentWeatherByCityName(cityName);
      final forecastData =
          await weatherFactory.fiveDayForecastByCityName(cityName);
      final newData = WeatherData(
        areaName: w.areaName,
        country: w.country,
        tempMax: w.tempMax?.celsius,
        tempMin: w.tempMin?.celsius,
        weatherDescription: w.weatherDescription,
        weatherIcon: w.weatherIcon,
        tempFeelsLike: w.tempFeelsLike?.celsius,
        forecast: forecastData, // Stockez les prévisions dans votre modèle
      );
      notifyListeners(); // Notifie les auditeurs du changement de données
      return newData;
    } catch (e) {
    
      print("Erreur lors de la récupération des données météorologiques : $e");
      throw e;
    }
  }
}

class WeatherProvider with ChangeNotifier {
  WeatherData? _weatherData;

  WeatherData? get weatherData => _weatherData;

  void updateWeatherData(WeatherData newData) {
    _weatherData = newData;
    notifyListeners();
  }
}
