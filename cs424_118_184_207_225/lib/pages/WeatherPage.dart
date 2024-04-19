import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather/weather.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WeatherPage extends StatefulWidget {
  WeatherPage({Key? key}) : super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class WeatherData extends ChangeNotifier {
  Map<String, List<Weather>> _userWeatherMap = {};

  List<Weather> getWeatherList(String email) => _userWeatherMap[email] ?? [];

  void addWeather(String email, Weather weather) {
    if (_userWeatherMap[email] == null) {
      _userWeatherMap[email] = [];
    }
    _userWeatherMap[email]!.add(weather);
    notifyListeners();
  }

  Future<void> refreshWeather(String email, WeatherFactory wf) async {
    List<Weather> updatedWeatherList = [];
    for (Weather weather in getWeatherList(email)) {
      final updatedWeather =
          await wf.currentWeatherByCityName(weather.areaName!);
      updatedWeatherList.add(updatedWeather);
    }
    _userWeatherMap[email] = updatedWeatherList;
    notifyListeners();
  }
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherFactory _wf = WeatherFactory("561e2d15e8273d87f567d08341baf1d1");

  Future<void> fetchData(String cityName) async {
    final email = FirebaseAuth.instance.currentUser?.email;
    if (email == null) return;

    try {
      final weather = await _wf.currentWeatherByCityName(cityName);
      Provider.of<WeatherData>(context, listen: false)
          .addWeather(email, weather);
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  void _showCityNameDialog() async {
    TextEditingController cityNameController = TextEditingController();
    bool showError = false; // Flag to track if error should be shown
    showDialog<void>(
      context: context,
      barrierDismissible: false, // Prevent dialog from closing on outside tap
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Text('Enter City Name'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: cityNameController,
                  decoration: InputDecoration(
                    hintText: "City name",
                    errorText: showError
                        ? 'City not found. Please enter a valid city name.'
                        : null,
                  ),
                  autofocus: true,
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel')),
              TextButton(
                child: const Text('OK'),
                onPressed: () async {
                  String cityName = cityNameController.text
                      .trim(); // Trim leading and trailing spaces
                  if (cityName.isEmpty) {
                    setState(() {
                      showError = true;
                    });
                  } else {
                    // If the city name is not empty, fetch data for it
                    await fetchData(cityName);
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        });
      },
    );
  }

  Future<void> _onRefresh() async {
    final email = FirebaseAuth.instance.currentUser?.email;
    if (email != null) {
      await Provider.of<WeatherData>(context, listen: false)
          .refreshWeather(email, _wf);
    }
  }

  @override
  Widget build(BuildContext context) {
    final email = FirebaseAuth.instance.currentUser?.email;
    final List<Weather> _weatherList = email != null
        ? Provider.of<WeatherData>(context).getWeatherList(email)
        : [];

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Background_Blanc_et_noir.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 55,
            left: 40,
            child: Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.8),
              ),
              child: IconButton(
                icon: Icon(Icons.home),
                iconSize: 35,
                onPressed: () {
                  Navigator.pushNamed(context, '/ CategoryPage ');
                  print("click Home");
                  // Handle home button press
                },
              ),
            ),
          ),
          Positioned(
            top: 55,
            right: 30,
            child: Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.8),
              ),
              child: IconButton(
                icon: Icon(Icons.settings),
                iconSize: 35,
                onPressed: () {
                  Navigator.pushNamed(context, "/ SettingPage ");
                  print("click Setting");
                  // Handle setting button press
                },
              ),
            ),
          ),
          Positioned(
            top: 55,
            right: 100,
            child: Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.8),
              ),
              child: IconButton(
                icon: Icon(Icons.person),
                iconSize: 35,
                onPressed: () {
                  Navigator.pushNamed(context, '/ profile ');
                  // Handle profile button press
                },
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 150,
            right: 0,
            child: Text(
              'Weather Page',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                height: 0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 210, 30, 0),
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                itemCount: _weatherList.length,
                itemBuilder: (context, index) {
                  final weather = _weatherList[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white.withOpacity(0.8),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 160,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    'http://openweathermap.org/img/wn/${weather.weatherIcon}@4x.png',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              DateFormat("MMMM d, hh:mm a")
                                  .format(DateTime.now()),
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 55),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              weather.areaName ?? "Unknown Location",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "${weather.temperature?.celsius?.toStringAsFixed(0)}°C",
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCityNameDialog,
        tooltip: 'Add City',
        child: const Icon(Icons.add),
      ),
    );
  }
}
