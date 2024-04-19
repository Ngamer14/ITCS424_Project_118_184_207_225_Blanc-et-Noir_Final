import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_app_midterm_first_haft/pages/WeatherPage.dart';
import 'package:provider/provider.dart';
import 'package:weather/weather.dart';
import 'package:air_quality/air_quality.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PMPage extends StatefulWidget {
  PMPage({Key? key}) : super(key: key);

  @override
  _PMPageState createState() => _PMPageState();
}

class CityData {
  Weather? weather;
  AirQualityData? airQualityData;
  String cityName;

  CityData({this.weather, this.airQualityData, required this.cityName});
}

Color getColorFromAqi(int? aqi) {
  if (aqi == null) return Colors.grey; // Unknown or no data
  if (aqi <= 50) return Colors.green;
  if (aqi <= 100) return Colors.yellow;
  if (aqi <= 150) return Colors.orange;
  if (aqi <= 200) return Colors.red;
  if (aqi <= 300) return Colors.purple;
  // AQI > 300
  return Colors
      .deepPurple; // You can choose any appropriate color for AQI > 300
}

class CityDataProvider extends ChangeNotifier {
  Map<String, List<CityData>> _userCityDataMap = {};

  List<CityData> getCityDataList(String email) => _userCityDataMap[email] ?? [];

  void addCityData(String email, CityData data) {
    if (_userCityDataMap[email] == null) {
      _userCityDataMap[email] = [];
    }
    _userCityDataMap[email]!.add(data);
    notifyListeners();
  }

  Future<void> refreshAllCities(
      String email, WeatherFactory wf, AirQuality aq) async {
    List<CityData> updatedCityList = [];
    for (CityData cityData in getCityDataList(email)) {
      final weather = await wf.currentWeatherByCityName(cityData.cityName);
      final airQualityData = await aq.feedFromCity(cityData.cityName);
      updatedCityList.add(CityData(
          weather: weather,
          airQualityData: airQualityData,
          cityName: cityData.cityName));
    }
    _userCityDataMap[email] = updatedCityList;
    notifyListeners();
  }
}

class _PMPageState extends State<PMPage> {
  final WeatherFactory _wf = WeatherFactory("561e2d15e8273d87f567d08341baf1d1");
  final AirQuality _airQuality =
      AirQuality('629b29e58569334aa436328b0c4d74c0689059bd');

  Future<void> fetchData(String cityName) async {
    final email = FirebaseAuth.instance.currentUser?.email;
    if (email == null) return;

    final weather = await _wf.currentWeatherByCityName(cityName);
    final airQualityData = await _airQuality.feedFromCity(cityName);
    Provider.of<CityDataProvider>(context, listen: false).addCityData(
        email,
        CityData(
            weather: weather,
            airQualityData: airQualityData,
            cityName: cityName));
  }

  Future<void> _onRefresh() async {
    final email = FirebaseAuth.instance.currentUser?.email;
    if (email != null) {
      await Provider.of<CityDataProvider>(context, listen: false)
          .refreshAllCities(email, _wf, _airQuality);
    }
  }

  void _showCityNameDialog() async {
    TextEditingController cityNameController = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        bool showError = false; // Flag to track if error should be shown
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Text('Enter City Name'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: cityNameController,
                  decoration: InputDecoration(hintText: "City name"),
                  autofocus: true,
                  onChanged: (value) {
                    setState(() {
                      showError = false; // Reset error flag when text changes
                    });
                  },
                ),
                if (showError)
                  Text(
                    'Invalid city name',
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: const Text('OK'),
                onPressed: () async {
                  String cityName = cityNameController.text;
                  if (cityName.isNotEmpty) {
                    await fetchData(cityName);
                    Navigator.of(context).pop();
                  } else {
                    // Show error if the city name is empty
                    setState(() {
                      showError = true;
                    });
                  }
                },
              ),
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final email = FirebaseAuth.instance.currentUser?.email;
    final List<CityData> citiesData = email != null
        ? Provider.of<CityDataProvider>(context).getCityDataList(email)
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
            //Home button top
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
                  Navigator.pushNamed(context, "/ CategoryPage ");
                  print("click Home");
                  // Handle home button press
                },
              ),
            ),
          ),
          Positioned(
            //Setting button top
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
                  // Handle setting button press
                },
              ),
            ),
          ),
          Positioned(
            // Profile button top
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
                  Navigator.pushNamed(context, "/ profile ");
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
              'Air Quality Index Page',
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
                itemCount: citiesData.length, // The number of cities
                itemBuilder: (context, index) {
                  final cityData = citiesData[index];
                  final aqiValue = cityData.airQualityData?.airQualityIndex;
                  final containerColor = getColorFromAqi(aqiValue);
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: containerColor,
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              cityData.weather?.areaName ?? "Unknown",
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${DateFormat("MMMM d, hh:mm a").format(DateTime.now())}",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 40),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              cityData.airQualityData?.toString() ?? "No data",
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "(AQI-US)",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 20,
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _showCityNameDialog();
              print('click');
            },
            tooltip: 'Add City',
            child: const Icon(Icons.add),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              // Navigate to the map page
              Navigator.pushNamed(context, "/ PM25Map ");
            },
            tooltip: 'Map',
            child: const Icon(Icons.map),
          ),
        ],
      ),
    );
  }
}
