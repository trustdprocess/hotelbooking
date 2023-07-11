import 'package:flutter/material.dart';

class userForm extends StatefulWidget {
  const userForm({super.key});

  @override
  State<userForm> createState() => _userFormState();
}

class _userFormState extends State<userForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Booking Registration "),
          elevation: 0,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: " Enter Your First Name",
                ),
              ),
              
            ),
          ],
        ),
      ),
    );
  }
}
