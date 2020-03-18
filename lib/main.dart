import 'package:flutter/material.dart';
import 'package:Software_Development/utils/route_generator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Software Development',
      theme: ThemeData(fontFamily: 'JosefinSans'),
      initialRoute: '/login-signup',
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}