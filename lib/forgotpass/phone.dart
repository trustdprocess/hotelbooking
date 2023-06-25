import 'package:email_otp/email_otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_app50/forgotpass/verification.dart';

class OTP extends StatefulWidget {
  const OTP({super.key});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    EmailOTP myauth = EmailOTP();
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password "),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "Enter Your Email Address",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                myauth.setConfig(
                    appEmail: "pankajpandey.p18@gmail.com",
                    appName: "Travel Eze",
                    userEmail: _emailController.text,
                    otpLength: 4,
                    otpType: OTPType.digitsOnly);
                if (await myauth.sendOTP() == true) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("OTP has been sent"),
                  ));
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => verification(myauth: myauth,)));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("OTP send failed"),
                  ));
                }
              },
              child: const Text("Send OTP")),
        ],
      ),
    );
  }
}
