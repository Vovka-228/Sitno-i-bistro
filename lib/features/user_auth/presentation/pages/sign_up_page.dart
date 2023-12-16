import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../../../../global/common/toast.dart';
import '../../firebase_auth_implementetion/firebase_auth_service.dart';
import '../widgets/form_container_widget.dart';
import 'login_page.dart';

final db = FirebaseFirestore.instance;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Sign Up",
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 30,
          ),
          FormContainerWidget(
            controller: _userNameController,
            hintText: "Username",
            isPasswordField: false,
          ),
          SizedBox(height: 10),
          FormContainerWidget(
            controller: _emailController,
            hintText: "Email",
            isPasswordField: false,
          ),
          SizedBox(height: 10),
          FormContainerWidget(
            controller: _passwordController,
            hintText: "Password",
            isPasswordField: true,
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              showToast(message: "User is successfully created");
              _signUp();
            },
            child: Container(
              width: double.infinity,
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.blue),
              child: Center(
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("У тебя уже че есть маза здесь?"),
              SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false);
                },
                child: Text(
                  "Войти",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }

  void _signUp() async {
    String username = _userNameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {

      final user_request = <String, String>{
        "email": "$email",
        "name": "",
        "surname": "",
        "username": "$username",
      };

      db.collection("users").doc(username).set(user_request).onError((e, _) => print("Error writing document: $e"));


      print("User is successfully created");

      Navigator.pushNamedAndRemoveUntil(context, "/navigation", (route) => false);
    } else {
      print("Some error happend");
    }
  }
}
