import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class WeatherForecastWidget extends StatelessWidget {
  final List<Weather> forecast;

  WeatherForecastWidget({required this.forecast});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: forecast.map((weather) {
          
          Color redColor = Colors.red;
          Color blueColor = Colors.blue;

          return Container(
            width: 130,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context)
                  .colorScheme
                  .primary, // Utilisez la couleur rouge
            ),
            margin: EdgeInsets.fromLTRB(0, 10, 15, 0),
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${weather.date!.day}/${weather.date!.month}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Container(
                      width: 65,
                      height: 65,
                      child: Image.network(
                        'https://openweathermap.org/img/wn/${weather.weatherIcon}@2x.png',
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${weather.tempMax?.celsius?.toStringAsFixed(1)}°C',
                      style: TextStyle(
                          color: redColor, // Utilisez la couleur rouge
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    Text(
                      '${weather.tempMin?.celsius?.toStringAsFixed(1)}°C',
                      style: TextStyle(
                          color: blueColor, // Utilisez la couleur bleue
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ],
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
