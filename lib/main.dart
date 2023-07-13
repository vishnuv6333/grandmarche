import 'package:flutter/material.dart';
import 'package:grandmarche/screens/splash_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import 'constant/router.dart';
import 'provider/resturant_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ResurantProvider>(
          create: (_) => ResurantProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: HexColor("#FF8C23"),
          colorScheme: ColorScheme.fromSeed(seedColor:HexColor("#FF8C23")),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        routes: RouteManage,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
