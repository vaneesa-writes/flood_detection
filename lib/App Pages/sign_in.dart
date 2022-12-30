import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flood_detection/App%20Pages/home.dart';
import 'package:flood_detection/App%20Pages/sign_up.dart';
import 'package:flood_detection/reusable_widgets/reusable.dart';
import 'package:flutter/material.dart';

var color = '#ADD8E6';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign In",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        //color: Colors.blueGrey,
        decoration: BoxDecoration(color: Colors.blueGrey),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 300),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/student.png"),
                const SizedBox(
                  height: 30,
                ),
                reusableTextField("Enter UserName", Icons.person_outline, false,
                    _nameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outline, true,
                    _passwordTextController),
                const SizedBox(
                  height: 50,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                        fontSize: 27, fontWeight: FontWeight.w700),
                  ),
                  onPressed: () async {
                    String name = _nameTextController.text.trim();
                    String password = _passwordTextController.text.trim();

                    QuerySnapshot snap = await FirebaseFirestore.instance
                        .collection("studentLogin")
                        .where('name', isEqualTo: name)
                        .get();

                    log(snap.docs[0]['password'].toString());

                    if (password == snap.docs[0]['password'].toString()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => homeScreen()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Invalid credentials")));
                    }
                  },
                  child: const Text('Sign In'),
                ),
                SizedBox(
                  height: 50,
                ),
                signUpOption()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
