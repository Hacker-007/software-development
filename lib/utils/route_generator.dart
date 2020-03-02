import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:software_development/pages/home_page.dart';
import 'package:software_development/pages/login_signup_page.dart';
import 'package:software_development/pages/login_page.dart';
import 'package:software_development/pages/settings_page.dart';
import 'package:software_development/pages/signup_page.dart';
import 'package:software_development/pages/account_page.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/': return MaterialPageRoute(builder: (_) => HomePage());
      case '/login-signup': return MaterialPageRoute(builder: (_) => LoginSignUpPage());
      case '/login': return MaterialPageRoute(builder: (_) => LoginPage());
      case '/signup': return MaterialPageRoute(builder: (_) => SignUpPage());
      case '/account': return MaterialPageRoute(builder: (_) => AccountPage());
      case '/settings': return MaterialPageRoute(builder: (_) => SettingsPage());
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