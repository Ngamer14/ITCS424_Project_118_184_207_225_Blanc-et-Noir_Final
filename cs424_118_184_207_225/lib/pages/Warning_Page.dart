import 'package:flutter/material.dart';

class WarningPage extends StatefulWidget {
  WarningPage({Key? key}) : super(key: key);

  @override
  _WarningPageState createState() => _WarningPageState();
}

class _WarningPageState extends State<WarningPage> {
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
            left: 50,
            top: 223,
            child: Container(
              width: 365,
              height: 95,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 365,
                      height: 95,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 6,
                    top: 4,
                    child: Container(
                      width: 165,
                      height: 40,
                      decoration: ShapeDecoration(
                        color: Color(0xFFD9D9D9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 17,
                    top: 12,
                    child: Text(
                      'Nakhon Pathom',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 17,
                    top: 53,
                    child: Text(
                      'Weather :',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 166,
                    top: 53,
                    child: Text(
                      'Raining',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 256,
                    top: 54,
                    child: Text(
                      'in 5 Days',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 50,
            top: 351,
            child: Container(
              width: 365,
              height: 95,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 365,
                      height: 95,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 6,
                    top: 4,
                    child: Container(
                      width: 165,
                      height: 40,
                      decoration: ShapeDecoration(
                        color: Color(0xFFD9D9D9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 50,
                    top: 12,
                    child: Text(
                      'Bangkok',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 17,
                    top: 53,
                    child: Text(
                      'Weather :',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 166,
                    top: 52,
                    child: Text(
                      'Storm',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 260,
                    top: 53,
                    child: Text(
                      'in 5 Day',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 50,
            top: 479,
            child: Container(
              width: 365,
              height: 95,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 365,
                      height: 95,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 6,
                    top: 4,
                    child: Container(
                      width: 165,
                      height: 40,
                      decoration: ShapeDecoration(
                        color: Color(0xFFD9D9D9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 37,
                    top: 12,
                    child: Text(
                      'SuPhanBuri',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 17,
                    top: 53,
                    child: Text(
                      'Weather :',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 166,
                    top: 52,
                    child: Text(
                      'Raining',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 261,
                    top: 53,
                    child: Text(
                      'in 5 Day',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 155,
            right: 0,
            child: Text(
              'Notification',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w800,
                height: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
