import 'package:flutter/material.dart';
import 'package:Software_Development/services/auth.dart';
import 'package:Software_Development/utils/colors.dart';
import 'package:Software_Development/utils/widget_utils.dart';

class SignUpPage extends StatelessWidget {
  
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
        child: SingleChildScrollView(
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
                onPressed: authService.signupWithEmailAndPassword,
                indexes: [0, 1, 2],
              ),
              WidgetUtils.createLineSeparator(),
              GestureDetector(
                child: Image.asset(
                  'assets/images/google_logo.png',
                  scale: 13,
                ),
                onTap: () async {
                  await authService.signinWithGoogle(context);
                  Navigator.of(context).pushNamed('/');
                }
              ),
            ]
          ),
        ),
      ),
    );
  }
}