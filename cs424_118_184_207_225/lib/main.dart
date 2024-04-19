import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_app_midterm_first_haft/pages/PreloginPage.dart';
import 'package:project_app_midterm_first_haft/pages/SignInPage.dart';
import 'package:project_app_midterm_first_haft/pages/loginPage.dart';
import 'package:project_app_midterm_first_haft/pages/CategoryPage.dart';
import 'package:project_app_midterm_first_haft/pages/LoadingPage.dart';
import 'package:project_app_midterm_first_haft/pages/WeatherPage.dart';
import 'package:project_app_midterm_first_haft/pages/Profile_Page.dart';
import 'package:project_app_midterm_first_haft/pages/Pm2.5_Page.dart';
import 'package:project_app_midterm_first_haft/pages/Warning_Page.dart';
import 'package:project_app_midterm_first_haft/pages/SettingPage.dart';
import 'package:project_app_midterm_first_haft/pages/authStatePage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyArNBviKWW7JODIT-U9DhSNok8Y_z4OiXI",
          appId: "1:450877646956:android:2b234e8804ecceb3ec5049",
          messagingSenderId: "450877646956",
          projectId: "project-app-e17ad"));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WeatherData()),
        ChangeNotifierProvider(create: (context) => CityDataProvider()),
      ],
      child: MyApp(),
    ),
  );

  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
// This widget is the root of your application .
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Workshop1 ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => PreLoginPage(),
        '/ pm ': (context) => PMPage(),
        "/ login ": (context) => LoginPage(),
        "/ profile ": (context) => ProfilePage(),
        "/ SignInPage ": (context) => SignInPage(),
        "/ CategoryPage ": (context) => CategoryPage(),
        "/ WeatherPage ": (context) => WeatherPage(),
        "/ WarningPage ": (context) => WarningPage(),
        "/ SettingPage ": (context) => SettingPage(),
        "/ LoginPage ": (context) => LoginPage(),
        "/LoadingPage": (context) => LoadingPage(),
      },
    );
  }
}
