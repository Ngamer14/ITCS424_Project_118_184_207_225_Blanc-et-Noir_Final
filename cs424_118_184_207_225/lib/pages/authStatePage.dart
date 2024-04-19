// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:project_app_midterm_first_haft/pages/PreloginPage.dart';
// import 'package:project_app_midterm_first_haft/pages/CategoryPage.dart';

// class AuthStatePage extends StatelessWidget {
//   const AuthStatePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return CategoryPage();
//           } else {
//             return PreLoginPage();
//           }
//         },
//       ),
//     );
//   }
// }
