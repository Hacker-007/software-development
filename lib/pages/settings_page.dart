import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:software_development/utils/widget_utils.dart';

class SettingsPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    bool isOn = false;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Settings',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  WidgetUtils.createSwitch('Dark Mode'),
                  WidgetUtils.createSwitch('Private Mode'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}