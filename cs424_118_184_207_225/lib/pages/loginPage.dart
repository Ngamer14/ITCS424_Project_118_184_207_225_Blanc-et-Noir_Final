import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  String _email = "";
  String _password = "";

  void _handleLogin() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      Navigator.pushNamed(context, '/LoadingPage');
      print("User Logged: ${userCredential.user!.email}");
    } catch (e) {
      print("Error During Logged: $e");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Login Error"),
            content: Text("Invalid email or password. Please try again."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
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
                        _handleLogin();
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
                      'Login',
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
