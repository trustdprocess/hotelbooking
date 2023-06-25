import 'package:flutter/material.dart';
import 'package:new_app50/homepage/home.dart';
import 'package:new_app50/login/login.dart';
import 'package:new_app50/splash/splash.dart';


class RouteGenerators {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => splashScreen());
           case '/login':
        return MaterialPageRoute(builder: (_) => loginpage());

      case '/home':
        return MaterialPageRoute(builder: (_) => homepage());
        
      default:
        return Error();
    }
  }
}

Route<dynamic> Error() {
  return MaterialPageRoute(builder: (_) => Scaffold(
    appBar: AppBar(title: Text("Error!"),),
  ));
}
