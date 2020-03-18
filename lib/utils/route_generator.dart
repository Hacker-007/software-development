import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:Software_Development/pages/home_page.dart';
import 'package:Software_Development/pages/login_signup_page.dart';
import 'package:Software_Development/pages/login_page.dart';
import 'package:Software_Development/pages/settings_page.dart';
import 'package:Software_Development/pages/signup_page.dart';
import 'package:Software_Development/pages/account_page.dart';
import 'package:Software_Development/pages/trip_page.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/': return MaterialPageRoute(builder: (_) => HomePage());
      case '/login-signup': return MaterialPageRoute(builder: (_) => LoginSignUpPage());
      case '/login': return MaterialPageRoute(builder: (_) => LoginPage());
      case '/signup': return MaterialPageRoute(builder: (_) => SignUpPage());
      case '/account': return MaterialPageRoute(builder: (_) => AccountPage());
      case '/settings': return MaterialPageRoute(builder: (_) => SettingsPage());
      case '/trip': {
        if(settings.arguments != null) {
          return MaterialPageRoute(
            builder: (_) => TripPage(
              currentStep: ((settings.arguments as Map<String, dynamic>)['currentStep']) ?? 0,
              restaurantSelected: ((settings.arguments as Map<String, dynamic>)['restaurantSelected'] as Map<String, dynamic>) ?? {},
            ),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => TripPage(
              currentStep: 0,
              restaurantSelected: {},
            ),
          );
        }
      }
      break;
      default: return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('An Error Occurred. The Page That You Are Trying To Access Does Not Exist.')
        ),
      );
    });
  }
}