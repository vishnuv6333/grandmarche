import 'package:flutter/material.dart';
import 'package:grandmarche/screens/HomePage.dart';
import 'package:grandmarche/screens/resturant_detail.dart';
import 'package:grandmarche/screens/splash_screen.dart';
import '../screens/login_screen.dart';


var RouteManage = <String, WidgetBuilder>{
  '/login': (context) => LoginScreen(),
  '/home': (context) =>  MyHomePage(),
  '/splash': (context) => const SplashScreen(),
  '/restarunt': (context) => ResturantScreen(),
};
