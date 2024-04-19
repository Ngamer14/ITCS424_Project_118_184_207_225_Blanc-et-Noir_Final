import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather/weather.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final WeatherFactory _wf = WeatherFactory("561e2d15e8273d87f567d08341baf1d1");
  Weather? _weather;

  final currentUser = FirebaseAuth.instance.currentUser!;

  final usersCollection = FirebaseFirestore.instance.collection("Users");

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final weather = await _wf.currentWeatherByCityName("Bangkok");
    setState(() {
      _weather = weather;
    });
  }

  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit $field"),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'cancel',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(newValue),
            child: Text(
              'save',
              style: TextStyle(color: Colors.green[300]),
            ),
          ),
        ],
      ),
    );

    if (newValue.trim().length > 0) {
      await usersCollection.doc(currentUser.email).update({field: newValue});
    }
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
                  Navigator.pushNamed(context, '/profile');
                  // Handle profile button press
                },
              ),
            ),
          ),
          Positioned(
            left: 200,
            top: 125,
            child: Text(
              ' Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 160, 30, 0),
            child: Stack(
              children: [
                Container(
                  width: 420,
                  height: 711,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Users")
                      .doc(currentUser.email)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final userData =
                          snapshot.data!.data() as Map<String, dynamic>;

                      return ListView(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 320,
                            height: 327.10,
                            child: Image.network(
                              'https://static.thenounproject.com/png/1122822-200.png',
                            ),
                            decoration: BoxDecoration(
                              color: Color(0x99CBD5E1),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Text(
                              "E-mail : ${currentUser.email!}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(9),
                            ),
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 10),
                            margin: const EdgeInsets.only(left: 15, right: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Username : ",
                                      style: TextStyle(color: Colors.grey[900]),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        editField('username');
                                        print("Edit");
                                      },
                                      icon: Icon(
                                        Icons.settings,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                  ],
                                ),
                                Text(userData['username']),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(9),
                            ),
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 10),
                            margin: const EdgeInsets.only(left: 15, right: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Age : ",
                                      style: TextStyle(color: Colors.grey[900]),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        editField('age');
                                        print("Edit");
                                      },
                                      icon: Icon(
                                        Icons.settings,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                  ],
                                ),
                                Text(userData['age']),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(9),
                            ),
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 10),
                            margin: const EdgeInsets.only(left: 15, right: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Location : ",
                                      style: TextStyle(color: Colors.grey[900]),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        editField('location');
                                        print("Edit");
                                      },
                                      icon: Icon(
                                        Icons.settings,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  // _weather?.areaName ?? "",
                                  // style: TextStyle(color: Colors.grey[900]),
                                  userData['location'],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error${snapshot.error}'),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
