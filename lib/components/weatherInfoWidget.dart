import 'package:flutter/material.dart';
import 'package:weatherapp/components/weatherForecastWidget.dart';
import 'package:weatherapp/models/weatherModel.dart';

class WeatherInfoWidget extends StatelessWidget {
  final WeatherData? weatherData;

  Color redColor = Color.fromARGB(255, 223, 3, 3);
  Color blueColor = Color.fromRGBO(4, 4, 220, 1);

  WeatherInfoWidget({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    if (weatherData == null) {
      return Container(
          alignment: Alignment.center,
          height: 500,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Sélectionnez une ville",
                style: const TextStyle(
                  fontFamily: "Montserrat",
                  color: Colors.black,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ));
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 30,
        ),
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.primary),
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
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
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
                                Icon(Icons.arrow_upward, color: redColor),
                                Text(
                                  "${weatherData!.tempMax!.toStringAsFixed(1)}°",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.arrow_downward, color: blueColor),
                                Text(
                                  "${weatherData!.tempMin!.toStringAsFixed(1)}°",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          weatherData!.weatherDescription!.toUpperCase(),
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 20,
                              color: Colors.white,
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
                          width: 80,
                          height: 80,
                          child: Image.network(
                            'https://openweathermap.org/img/wn/${weatherData!.weatherIcon}@2x.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        Text(
                          "${weatherData!.tempFeelsLike!.toStringAsFixed(1)}°",
                          style: const TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            )),
        SizedBox(
          height: 25,
        ),
        WeatherForecastWidget(forecast: weatherData!.forecast!),
      ],
    );
  }
}
