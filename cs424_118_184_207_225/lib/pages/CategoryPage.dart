import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart';
import 'package:air_quality/air_quality.dart';

// enum AppState { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING }

class CategoryPage extends StatefulWidget {
  CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final WeatherFactory _wf = WeatherFactory("561e2d15e8273d87f567d08341baf1d1");
  Weather? _weather;
  String _key = '629b29e58569334aa436328b0c4d74c0689059bd';
  late AirQuality _airQuality;

  late List<AirQualityData> _data = [];

  @override
  void initState() {
    super.initState();
    _airQuality = AirQuality(_key);
    fetchData("Bangkok");
  }

  Future<void> fetchData(String cityName) async {
    final weather = await _wf.currentWeatherByCityName(cityName);
    setState(() {
      _weather = weather;
    });

    AirQualityData feedFromCity = await _airQuality.feedFromCity(cityName);

    setState(() {
      _data.add(feedFromCity);
    });
  }

  @override
  Widget build(BuildContext context) {
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
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 125, 30, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/ WeatherPage ');
                      },
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.cloudy_snowing,
                                size: 120, color: Colors.blueGrey[300]),
                            Text(
                              "Weather",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/ pm ');
                        print("Button pressed: Air quality");
                      },
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.air,
                                size: 120, color: Colors.orange[400]),
                            Text(
                              "Air quality",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/ WarningPage ');
                        print("Button pressed: Warning list");
                      },
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.security_update_warning,
                                size: 120, color: Colors.blueAccent[700]),
                            Text(
                              "Warning list",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        print("Button pressed: UV index");
                      },
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.sunny,
                                size: 120, color: Colors.orangeAccent[700]),
                            Text(
                              "UV index",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "Current Location",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/ WeatherPage ");
                  },
                  child: Container(
                    width: 450,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      image: DecorationImage(
                        image: AssetImage('assets/images/Group 133.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 160,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    'http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              "${DateFormat("MMMM d , hh:mm a").format(DateTime.now())}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 20),
                            ),

                            // Add more widgets as needed
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _weather?.areaName ?? "",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),

                            Text(
                              "${_weather?.temperature?.celsius?.toStringAsFixed(0)}°C",
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                            // Add more widgets as needed
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/ pm ');
                    print("Button pressed: long bar AQI");
                  },
                  child: Container(
                    width: 450,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.red,
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _weather?.areaName ?? "",
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              "${DateFormat("MMMM d , hh:mm a").format(DateTime.now())}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 20),
                            ),

                            // Add more widgets as needed
                          ],
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              // Display AQI value
                              // "${_data[0].toString()}",
                              (_data.isNotEmpty) ? "${_data[0]}" : "No data",
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
                                  fontSize: 20),
                            ),
                            // Add more widgets as needed
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
