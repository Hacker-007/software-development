import 'package:Software_Development/services/auth.dart';
import 'package:Software_Development/services/crud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Software_Development/utils/colors.dart';
import 'package:Software_Development/utils/widget_utils.dart';

class AccountPage extends StatelessWidget {

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
            icon: Image.asset('assets/images/back_button.png'),
            onPressed: () => Navigator.pop(context),
            color: colors['Green'],
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20.0, right: 15.0),
            child: IconButton(
              icon: Image.asset('assets/images/settings.png'),
              onPressed: () => Navigator.of(context).pushNamed('/settings'),
              color: colors['Green'],
            ),
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _introduction(),
              WidgetUtils.createForm(
                ['Full Name', 'Email Address'],
                'Update Account',
                validatorMap: { 
                  'Email Address': (String email) => RegExp(r'\S+@\w+\.\w+').hasMatch(email) ? null : 'Please Enter A Valid Email.'
                },
                path: '/',
                onPressed: CrudOperations.update,
                indexes: [0, 1],
              ),
              WidgetUtils.createButton(
                context,
                'Sign Out',
                colors['Purple'],
                path: '/login-signup',
                onPressed: () async {
                  await authService.signout();
                  Navigator.of(context).pushNamed('/login-signup'); 
                }
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
                      CrudOperations.delete();
                      Navigator.of(context).pushNamed('/login-signup');
                    }
                  );
                },
                path: '/',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _introduction() {
    if(authService.user['Photo URL'] != '') {
      return Column(
        children: <Widget>[
          Text(
            'Hello, ${authService.user["Full Name"]}',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage('${authService.user["Photo URL"]}'),
              radius: 35.0,
            ),
          ),
        ],
      );
    } else {
      return Text(
        'Hello, ${authService.user["Full Name"]}',
        style: TextStyle(
          fontSize: 20.0,
        ),
      );
    }
  }
}