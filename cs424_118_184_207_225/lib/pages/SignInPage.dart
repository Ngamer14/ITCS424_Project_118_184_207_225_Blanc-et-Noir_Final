import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPage createState() => _SignInPage();
}

class _SignInPage extends State<SignInPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  String _email = "";
  String _password = "";

  void _handleSignUp() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      print("User Registered: ${userCredential.user!.email}");

      FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email!)
          .set({
            'username': _emailTextController.text.split(RegExp(r'[.@]')).first,

            'age' : 'Add your ages',
            'location' : 'Add your location'
          });
    } catch (e) {
      print("Error During Registration: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.only(top: 25, left: 30),
          child: BackButton(
            color: Colors.white.withOpacity(0.5),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Group 133.png'),
            fit: BoxFit.cover,
          ),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 100),
                  Container(
                    child: TextFormField(
                      controller: _emailTextController,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          size: 25,
                          color: Colors.grey,
                        ),
                        filled: true,
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Colors.grey.withOpacity(1),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 35),
                  Container(
                    child: TextFormField(
                      controller: _passwordTextController,
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          size: 25,
                          color: Colors.grey,
                        ),
                        filled: true,
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: Colors.grey.withOpacity(1),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _handleSignUp();

                        Navigator.pushNamed(context, '/');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      textStyle: TextStyle(fontSize: 20),
                      minimumSize: Size(420, 60),
                    ),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
