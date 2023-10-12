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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
        useMaterial3: true,
        textTheme: TextTheme(
          titleLarge:
              TextStyle(color: Colors.white), // Exemple pour le style de titre
          titleMedium: TextStyle(
              color: Colors.white), // Exemple pour le style de sous-titre
          bodyMedium: TextStyle(
              color: Colors.white), // Exemple pour le style de texte du corps
          // Vous pouvez personnaliser d'autres styles de texte ici
        ),
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
        centerTitle: true,
        title: Text('WeazApp',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        decoration: InputDecoration(
                          labelText: 'Ville',
                          prefixIcon: Icon(Icons
                              .location_city), // Icône à gauche du champ de texte
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(10.0), // Bordure arrondie
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height:
                        56.0, // Réglez la hauteur pour correspondre à celle du TextField
                    child: ElevatedButton(
                      onPressed: () {
                        String cityName = _cityController.text;

                        // Appel de la fonction pour récupérer les données météorologiques
                        _fetchWeatherData(cityName);
                        _cityFocusNode.unfocus();

                        _cityController.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor:
                            Colors.deepPurple, // Couleur du texte du bouton
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Bordure arrondie du bouton
                        ),
                      ),
                      child: Text('Récupérer la météo'),
                    ),
                  ),
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
        )
      ])),
    );
  }
}
