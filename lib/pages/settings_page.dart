import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Software_Development/utils/colors.dart';
import 'package:Software_Development/utils/widget_utils.dart';

class SettingsPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[50],
        elevation: 0.0,
        leading: Padding(
          padding: EdgeInsets.only(top: 20.0, left: 15.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
            color: colors['Green'],
            iconSize: 28.0,
          ),
        ),
      ),
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
                  // WidgetUtils.createSwitch('Private Mode'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}