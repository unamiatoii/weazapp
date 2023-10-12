import 'package:flutter/material.dart';
import 'package:weatherapp/components/weatherForecastWidget.dart';
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

    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.deepPurple),
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${weatherData!.areaName}, ${weatherData!.country}",
                          style: const TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 8,
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
                                    decoration: TextDecoration.none,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.arrow_downward,
                                    color: Colors.blue),
                                Text(
                                  "${weatherData!.tempMin!.toStringAsFixed(1)}°",
                                  style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          weatherData!.weatherDescription!.toUpperCase(),
                          style: const TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
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
                            decoration: TextDecoration.none,
                            fontSize: 36,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            )),
        WeatherForecastWidget(forecast: weatherData!.forecast!),
      ],
    );
  }
}
