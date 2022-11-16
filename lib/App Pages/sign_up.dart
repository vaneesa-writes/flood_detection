import 'package:firebase_auth/firebase_auth.dart';
import 'package:flood_detection/App Pages/home.dart';
import 'package:flood_detection/reusable_widgets/reusable.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
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
                const SizedBox(
                  height: 200,
                ),
                reusableTextField("Enter UserName", Icons.person_outline, false,
                    _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Email Id", Icons.person_outline, false,
                    _emailTextController),
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
                    try {
                      final user = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: _emailTextController.text.trim(),
                              password: _passwordTextController.text.trim());

                      if (user != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => uploadimage()));
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: const Text('Sign In'),
                ),
              ],
            ),
          ))),
    );
  }
}
