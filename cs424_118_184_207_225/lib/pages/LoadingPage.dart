import 'dart:async';
import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    // Create a Timer to navigate after 3 seconds
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(
          context, '/ CategoryPage '); // Navigate to home page
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(), // Loading indicator
            SizedBox(height: 20),
            Text('Loading...'), // Loading text
          ],
        ),
      ),
    );
  }
}
