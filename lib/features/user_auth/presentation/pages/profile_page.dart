import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("ProfilePage"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
              "Профиль",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            )),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, "/login", (route) => false);
              },
              child: Container(
                height: 45,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.orange[300],
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "Выйти",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
