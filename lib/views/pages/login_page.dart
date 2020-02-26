import 'package:flutter/material.dart';
import 'package:software_development/views/utils/widget_utils.dart';

class LoginPage extends StatelessWidget {
  
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
              ['Email Address', 'Password'],
              'Login',
              validatorMap: { 
                'Email Address': (String email) => RegExp(r'\S+@\w+\.\w+').hasMatch(email) ? null : 'Please Enter A Valid Email.'
              },
              path: '/',
              useDotsOnLast: true,
            ),
            WidgetUtils.createLineSeparator(),
          ]
        ),
      ),
    );
  }
}