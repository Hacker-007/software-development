import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:software_development/views/utils/colors.dart';
import 'package:software_development/views/utils/widget_utils.dart';

class AccountPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hello, John',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            WidgetUtils.createForm(
              ['Full Name', 'Email Address', 'Password'],
              'Update Account',
              validatorMap: { 
                'Email Address': (String email) => RegExp(r'\S+@\w+\.\w+').hasMatch(email) ? null : 'Please Enter A Valid Email.'
              },
              path: '/',
              useDotsOnLast: true,
            ),
            WidgetUtils.createButton(
              context,
              'Sign Out',
              colors['Purple'],
              path: '/',
            ),
            WidgetUtils.createButton(
              context,
              'Delete Account',
              colors['Red'],
              onPressed: () {
                WidgetUtils.createYesOrNoDialog(
                  context,
                  'Delete Account',
                  'Are You Sure You Want To Delete Your Account? This Action Is Irreversible.',
                  onConfirmation: () {
                    // Save To DB
                    Navigator.of(context).pop();
                  }
                );
              },
              path: '/',
            ),
          ],
        ),
      ),
    );
  }
}