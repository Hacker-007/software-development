import 'package:Software_Development/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:Software_Development/utils/colors.dart';
import 'package:Software_Development/utils/widget_utils.dart';

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
        WidgetUtils.createButton(
          context,
          'Login', 
          colors['Dark Gray'],
          onPressed: () async {
            Map<String, dynamic> user = await authService.getRememberedUser();
            if(user.length != 0) {
              Navigator.of(context).pushNamed('/');
            } else {
              Navigator.of(context).pushNamed('/login');
            }
          }
        ),
        WidgetUtils.createLineSeparator(),
        WidgetUtils.createButton(
          context,
          'Sign Up',
          colors['Dark Gray'],
          path: '/signup'
        ),
      ]
    );
  }
}