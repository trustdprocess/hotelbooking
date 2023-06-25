import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_app50/forgotpass/phone.dart';

import '../login/login.dart';

class forpass extends StatefulWidget {
  const forpass({super.key});

  @override
  State<forpass> createState() => _forpassState();
}

class _forpassState extends State<forpass> {
  TextEditingController pass = TextEditingController();
  TextEditingController pass2 = TextEditingController();
  TextEditingController _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  RegExp user = RegExp(r'^[a-z A-Z 0-9 @ .\-]');
  RegExp passreg = RegExp(r'^[a-z A-Z 0-9 . _ @\-]');
  RegExp _emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
  bool _isObsecure = true;
  bool _isObsecure1 = true;
  Future<void> resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email.text);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Password reset email sent")));
      Navigator.push(context, MaterialPageRoute(builder: (_) => loginpage()));
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Unable To Reset Password")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "travel Go",
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid E-mail';
                  } else if (!_emailRegex.hasMatch(value)) {
                    return "Enter email with a-z A-Z 0-9 . @ - ";
                  } else if (value.length <= 4) {
                    return "Enter the length of more than 4";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    hintText: "Someone@Example.com",
                    labelText: "E-mail",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                obscureText: _isObsecure,
                controller: pass,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid Password';
                  } else if (!passreg.hasMatch(value)) {
                    return "Enter username with a-z A-Z 0-9 . @ - ";
                  } else if (value.length <= 4) {
                    return "Enter the length of more than 4";
                  } else if (pass.text != pass2.text) {
                    return "Passwords don't match";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    hintText: "Password",
                    labelText: "Password",
                    prefixIcon: Icon(Icons.password),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isObsecure = !_isObsecure;
                          });
                        },
                        icon: _isObsecure
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                obscureText: _isObsecure1,
                controller: pass2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid Password';
                  } else if (!user.hasMatch(value)) {
                    return "Enter username with a-z A-Z 0-9 . @ - ";
                  } else if (value.length <= 4) {
                    return "Enter the length of more than 4";
                  } else if (pass.text != pass2.text) {
                    return "Passwords don't match";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    hintText: "Confirm Password",
                    labelText: "Confirm Password",
                    prefixIcon: Icon(Icons.password),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObsecure1 = !_isObsecure1;
                        });
                      },
                      icon: _isObsecure1
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16))),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                if (_formKey.currentState?.validate() == true) {
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                    resetPassword();

                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => loginpage()));
                  }
                }
              },
              child: AnimatedContainer(
                duration: Duration(seconds: 2),
                child: Container(
                  height: 50,
                  width: 180,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(16)),
                  child: Center(
                      child: Text(
                    "Reset Password",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
