import 'package:flutter/material.dart';
import 'package:weatherapp/components/weatherInfoWidget.dart';
import 'package:weatherapp/models/weatherModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white10),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _cityController = TextEditingController();
  WeatherData? _weatherData;
  FocusNode _cityFocusNode = FocusNode();

  Future<void> _fetchWeatherData(String cityName) async {
    try {
      WeatherData weatherData = await WeatherData().fetchWeatherData(cityName);
      setState(() {
        _weatherData = weatherData;
      });
    } catch (e) {
      print("Erreur lors de la récupération des données météorologiques : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('WeazApp'),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        focusNode: _cityFocusNode,
                        controller: _cityController,
                        decoration: InputDecoration(labelText: 'Ville'),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      String cityName = _cityController.text;

                      // Appel de la fonction pour récupérer les données météorologiques
                      _fetchWeatherData(cityName);

                      _cityController.clear();
                      _cityFocusNode.unfocus();
                    },
                    child: Text('Récupérer la météo'),
                  )
                ],
              ),
              if (_weatherData != null)
                WeatherInfoWidget(
                  weatherData: _weatherData,
                )
              else
                Text('Sélectionnez une ville pour obtenir la météo.'),
            ],
          ),
        ));
  }
}
