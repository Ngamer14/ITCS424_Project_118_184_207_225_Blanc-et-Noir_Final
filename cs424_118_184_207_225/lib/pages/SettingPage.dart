import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPage createState() => _SettingPage();
}

class _SettingPage extends State<SettingPage> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  void signOut() {
    FirebaseAuth.instance.signOut();
    Navigator.pushNamed(context, '/');
  }

  void _changePassword({String? email}) async {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Change Password"),
      content: Column(
        mainAxisSize: MainAxisSize.min, // Use min size to prevent oversizing
        children: [
          TextField(
            controller: currentPasswordController,
            autofocus: true,
            decoration: InputDecoration(labelText: 'Current Password', hintText: 'Enter current password'),
            obscureText: true, // Masks the password
          ),
          SizedBox(height: 20), // Add some spacing between the fields
          TextField(
            controller: newPasswordController,
            decoration: InputDecoration(labelText: 'New Password', hintText: 'Enter new password'),
            obscureText: true, // Masks the password
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: TextStyle(color: Colors.red)),
        ),
        TextButton(
          onPressed: () async {
            // Use the controllers to get the text
            String currentPassword = currentPasswordController.text;
            String newPassword = newPasswordController.text;

            if (email != null && currentPassword.isNotEmpty && newPassword.isNotEmpty) {
              final user = FirebaseAuth.instance.currentUser;
              final cred = EmailAuthProvider.credential(email: email, password: currentPassword);

              try {
                await user?.reauthenticateWithCredential(cred);
                await user?.updatePassword(newPassword);
                Navigator.pop(context); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password successfully changed')));
              } catch (error) {
                Navigator.pop(context); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error changing password')));
                print(error.toString());
              }
            }
          },
          child: Text('Save', style: TextStyle(color: Colors.green[300])),
        ),
      ],
    ),
  );
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
            left: 0,
            right: 0,
            top: 225,
            child: Text(
              ' Settings',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                height: 0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 300, 30, 0),
            child: Stack(
              children: [
                Container(
                  width: 400,
                  height: 600,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                ListView(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        "Accounts : ",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/ profile ");
                        print(" Edit profile");
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 15),
                        height: 50,
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.white),
                            bottom: BorderSide(color: Colors.white),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.person,
                              size: 35,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Edit Profile",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.pushNamed(context, "/ profile ");
                         _changePassword(email: currentUser.email!);
                        print("Change Password");
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 15),
                        height: 50,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.white),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.password,
                              size: 35,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Change Password",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        "Options : ",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.pushNamed(context, "/ profile ");
                        print(" Notification");
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 15),
                        height: 50,
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.white),
                            bottom: BorderSide(color: Colors.white),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.notifications_active,
                              size: 35,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Notification",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.pushNamed(context, "/ profile ");
                        print("Change language");
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 15),
                        height: 50,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.white),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.language,
                              size: 35,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Language",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        signOut();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        textStyle: TextStyle(fontSize: 20),
                        minimumSize: Size(420, 60),
                      ),
                      child: const Text(
                        'Log Out',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
