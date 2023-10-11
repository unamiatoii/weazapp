import 'package:flutter/material.dart';
import 'package:weatherapp/models/weatherModel.dart';

class WeatherInfoWidget extends StatelessWidget {
  final WeatherData? weatherData;

  WeatherInfoWidget({required this.weatherData});
 

  @override
  Widget build(BuildContext context) {
    if (weatherData == null) {
      return Container(
        padding: EdgeInsets.all(10.0),
        child: Text(
          "Sélectionnez une ville",
          style: const TextStyle(
            fontFamily: "Montserrat",
            color: Colors.black,
            decoration: TextDecoration.none,
            fontSize: 24,
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.greenAccent),
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${weatherData!.areaName}, ${weatherData!.country}",
                style: const TextStyle(
                  fontFamily: "Montserrat",
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(Icons.arrow_upward, color: Colors.red),
                      Text(
                        "${weatherData!.tempMax!.toStringAsFixed(1)}°",
                        style: const TextStyle(
                          fontFamily: "Montserrat",
                          color: Colors.black,
                          decoration: TextDecoration.none,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.arrow_downward, color: Colors.blue),
                      Text(
                        "${weatherData!.tempMin!.toStringAsFixed(1)}°",
                        style: const TextStyle(
                          fontFamily: "Montserrat",
                          color: Colors.black,
                          decoration: TextDecoration.none,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                "${weatherData!.weatherDescription}",
                style: const TextStyle(
                  fontFamily: "Montserrat",
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.center,
                width: 100,
                height: 100,
                child: Image.network(
                  'https://openweathermap.org/img/wn/${weatherData!.weatherIcon}@2x.png',
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                "${weatherData!.tempFeelsLike!.toStringAsFixed(1)}°",
                style: const TextStyle(
                  fontFamily: "Montserrat",
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
