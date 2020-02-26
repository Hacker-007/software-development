import 'package:flutter/material.dart';
import 'package:software_development/views/utils/colors.dart';
import 'package:software_development/views/utils/widget_utils.dart';

class LoginSignUpPage extends StatelessWidget {

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
            createButtons(context),
          ],
        ),
      ),
    );
  }

  Widget createButtons(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        WidgetUtils.createButton(context, 'Login', colors['Dark Gray'], path: '/login'),
        WidgetUtils.createLineSeparator(),
        WidgetUtils.createButton(context, 'Sign Up', colors['Dark Gray'], path: '/signup'),
      ]
    );
  }
}