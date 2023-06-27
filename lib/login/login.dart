import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:new_app50/Authentication.dart';
import 'package:new_app50/admin/admin.dart';
import 'package:new_app50/forgotpass/phone.dart';
import 'package:new_app50/homepage/homeanimation.dart';

import '../forgot/forgot.dart';
import '../forgotpass/forgotpass.dart';
import '../homepage/home.dart';
import '../signup/signup.dart';

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  _loginpageState createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  bool _isAdmin = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  RegExp _emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
  RegExp _passwordRegex = RegExp(r'^[a-zA-Z0-9_@.\-]{3,20}$');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _loginWithEmailPassword() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      if (email == "admin@example.com" && password == "admin123") {
        _isAdmin = true;
      }

      if (_isAdmin) {
        // Navigate to the admin panel screen
        // Replace `AdminPanelScreen` with your desired admin panel screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => adminPanel()),
        );
      } else {
        _signInWithEmailPassword();
      }
    }
  }

  Future<void> _signInWithEmailPassword() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.toString(),
        password: _passwordController.text.toString(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Successful!")),
      );

      // Navigate to the home screen
      // Replace `HomeAnimation` with your desired home screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => homeAnimation()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Failed: Email and Password Incorrect")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: const Text("Travel Eze"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid email';
                    } else if (!_emailRegex.hasMatch(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: "someone@gmail.com",
                    labelText: "E-mail",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    } else if (!_passwordRegex.hasMatch(value)) {
                      return 'Enter a valid password';
                    }
                    return null;
                  },
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.password),
                    hintText: "Password",
                    labelText: "Password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                      icon: _isObscure
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: _loginWithEmailPassword,
                child: AnimatedContainer(
                  duration: Duration(seconds: 2),
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              SizedBox(height: 0),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => OTP()),
                  );
                },
                child: Text("Forgot Password ?"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => forgot()),
                  );
                },
                child: Text("Don't Have an account?"),
              ),
              SizedBox(height: 20),
              Center(child: Text('or login with')),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      AuthService().signInWithGoogle();
                    },
                    child: Image.asset(
                      "assets/google.webp",
                      height: 80,
                      width: 80,
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      "assets/facebook.jpg.avif",
                      height: 80,
                      width: 80,
                    ),
                  ),
                  if (_isAdmin) ...[
                    Center(
                      child: Text("Admin Panel"),
                    )
                  ]
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
