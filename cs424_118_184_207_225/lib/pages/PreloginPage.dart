import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';

class PreLoginPage extends StatefulWidget {
  PreLoginPage({Key? key}) : super(key: key);

  @override
  _PreLoginPageState createState() => _PreLoginPageState();
}

class _PreLoginPageState extends State<PreLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Group 133.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 400,
              ),
              // You can customize the size and appearance of the Sign In Button here
              //Google button
              SignInButton(
                buttonType: ButtonType.google,
                buttonSize: ButtonSize.large,
                width: 350,
                onPressed: () {
                  print('click');
                },
              ),
              SizedBox(
                height: 35,
              ),
              //Facebook button
              SignInButton(
                buttonType: ButtonType.facebook,
                buttonSize: ButtonSize.large,
                width: 350,
                onPressed: () {
                  print('click');
                },
              ),
              SizedBox(
                height: 35,
              ),
              //Apple Button
              SignInButton(
                buttonType: ButtonType.apple,
                buttonSize: ButtonSize.large,
                width: 350,
                onPressed: () {
                  print('click');
                },
              ),
              SizedBox(
                height: 35,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 3,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text(
                        'Or',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 3,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/ login ');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  textStyle: TextStyle(fontSize: 20),
                  minimumSize: Size(370, 50),
                ),
                child: const Text('Sign in with Password' , style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              SizedBox(
                height: 125,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Dont have an account?',style: TextStyle(color: Colors.grey,fontSize:20,),),
                  SizedBox(
                    width: 7,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/ SignInPage ');
                    },
                    child: Text(
                    'Sign up',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  ),
                  
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
