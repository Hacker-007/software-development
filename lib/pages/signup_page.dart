import 'package:flutter/material.dart';
import 'package:software_development/services/auth.dart';
import 'package:software_development/services/crud.dart';
import 'package:software_development/utils/widget_utils.dart';

class SignUpPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Logo',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            WidgetUtils.createForm(
              ['Full Name', 'Email Address', 'Password'], 
              'Sign Up',
              path: '/',
              useDotsOnLast: true,
              onPressed: authService.googleSignIn,
              indexes: [],
            ),
            WidgetUtils.createLineSeparator(),
          ]
        ),
      ),
    );
  }
}