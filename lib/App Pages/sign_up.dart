import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flood_detection/App%20Pages/home.dart';
import 'package:flood_detection/reusable_widgets/reusable.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          //color: Colors.blueGrey,
          decoration: BoxDecoration(color: Colors.blueGrey),
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 200),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/student.png"),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter your Nmae", Icons.person_outline,
                    false, _nameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outlined, true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                        fontSize: 27, fontWeight: FontWeight.w700),
                  ),
                  onPressed: () async {
                    String name = _nameTextController.text.trim();
                    String password = _passwordTextController.text.trim();
                    FirebaseFirestore.instance.collection("studentLogin").add({
                      "name": name,
                      "password": password,
                    }).then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => homeScreen()));
                    }).catchError((error) => ScaffoldMessenger.of(context)
                        .showSnackBar(
                            SnackBar(content: Text("Sign Up Failed"))));
                  },
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ))),
    );
  }
}
