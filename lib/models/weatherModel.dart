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

  WeatherData({
    this.areaName,
    this.country,
    this.tempMax,
    this.tempMin,
    this.weatherDescription,
    this.weatherIcon,
    this.tempFeelsLike,
  });

  Future<WeatherData> fetchWeatherData(String cityName) async {
    final apiKey =
        "cd820212af00e720a383783dbb7a591a"; // Remplacez par votre clé d'API
    final weatherFactory = WeatherFactory(apiKey, language: Language.FRENCH);

    try {
      final w = await weatherFactory.currentWeatherByCityName(cityName);
      final newData = WeatherData(
        areaName: w.areaName,
        country: w.country,
        tempMax: w.tempMax?.celsius,
        tempMin: w.tempMin?.celsius,
        weatherDescription: w.weatherDescription,
        weatherIcon: w.weatherIcon,
        tempFeelsLike: w.tempFeelsLike?.celsius,
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
