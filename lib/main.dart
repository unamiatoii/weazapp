import 'package:flutter/material.dart';
import 'package:weatherapp/components/weatherInfoWidget.dart';
import 'package:weatherapp/models/weatherModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    const customColorScheme = ColorScheme(
      primary: Color.fromARGB(255, 66, 165, 245), // Couleur principale
      secondary: Color(0xFF242423), // Couleur secondaire
      surface: Colors.white,
      background: Colors.white,
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.black,
      onBackground: Colors.black,
      onError: Colors.white,
      brightness: Brightness.light,
    );

    final customTheme = ThemeData(
      fontFamily: "Montserrat",
      colorScheme: customColorScheme,
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: customColorScheme.secondary,
        ), // Titre
        titleMedium: TextStyle(
          color: customColorScheme.secondary,
        ), // Sous-titre
        bodyMedium: TextStyle(
          color: customColorScheme.secondary,
        ), // Corps du texte
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: customTheme, //Theme perso
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
  bool _isLoading = false;

  Future<void> _fetchWeatherData(String cityName) async {
    try {
      setState(() {
        _isLoading = true;
      });

      WeatherData weatherData = await WeatherData().fetchWeatherData(cityName);

      setState(() {
        _weatherData = weatherData;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      print("Erreur lors de la récupération des données météorologiques : $e");
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              title: const Text(
                'Erreur',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              content: Text(
                'Une erreur s\'est produite : $e',
              ),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Fermer',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WeazApp'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                              color: Theme.of(context).colorScheme.onPrimary,
                            )),
                            child: TextField(
                              focusNode: _cityFocusNode,
                              controller: _cityController,
                              decoration: InputDecoration(
                                labelText: 'Ville',
                                prefixIcon: const Icon(Icons.location_city),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                labelStyle: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 56.0,
                      child: ElevatedButton(
                        onPressed: () {
                          String cityName = _cityController.text;
                          _fetchWeatherData(cityName);
                          _cityController.clear();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .primary, // Couleur du texte du bouton
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Text('Récupérer la météo'),
                      ),
                    ),
                  ],
                ),
                if (_isLoading)
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  )
                else if (_weatherData != null)
                  WeatherInfoWidget(
                    weatherData: _weatherData,
                  )
                else
                  Container(
                    height: 150,
                    width: 500,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: const Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Sélectionnez une ville",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        )),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
