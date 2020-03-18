import 'package:Software_Development/utils/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomForm extends StatefulWidget {
  final List<String> textFieldNames;
  final Map<String, Function> validatorMap;
  final Function onPressed;
  final List<int> indexes;
  final bool useDotsOnLast;
  final String nameOfButton;
  final Color color;
  final String path;

  CustomForm({Key key,
              @required this.textFieldNames, 
              @required this.validatorMap, 
              @required this.onPressed, 
              this.indexes, 
              this.useDotsOnLast, 
              this.nameOfButton, 
              this.color, 
              this.path
            }) : super(key: key);

  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final _formKey = GlobalKey<FormState>();
  List<TextEditingController> _textControllers;
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    this._isLoading = false;
    this._textControllers = List();
    for(int i = 0; i < this.widget.textFieldNames.length; i++) {
      this._textControllers.add(TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = new List<Widget>();
    for(int i = 0; i < this.widget.textFieldNames.length; i++) {
      String name = this.widget.textFieldNames.elementAt(i);
      children.add(
        WidgetUtils.createTextField(
          name,
          isLast: i == this.widget.textFieldNames.length - 1,
          showDots: i == this.widget.textFieldNames.length - 1 && this.widget.useDotsOnLast,
          validator: this.widget.validatorMap.containsKey(name) ? this.widget.validatorMap[name] : (text) => text.isEmpty ? 'Please Enter A ${this.widget.textFieldNames.elementAt(i)}' : null,
          controller: this._textControllers.elementAt(i),
        )
      );
    }
    
    if(this._isLoading) {
      children.add(CircularProgressIndicator());
    }

    children.add(
      WidgetUtils.createButton(
        context, 
        this.widget.nameOfButton, 
        this.widget.color, 
        onPressed: () async {
          if(_formKey.currentState.validate()) {
            setState(() => this._isLoading = true);
            List<String> parameters = List();
            for(int i in this.widget.indexes) {
              parameters.add(this._textControllers.elementAt(i).text.trim());
            }

            (this.widget.indexes.length != 0 ? this.widget.onPressed(context, parameters) as Future<dynamic> : this.widget.onPressed(context) as Future<dynamic>)
                  .then(
                    (user) {
                      setState(() => this._isLoading = false);
                      Navigator.of(context).pushNamed(widget.path);
                    }, 
                    onError: (e) async {
                      setState(() => this._isLoading = false);
                      await showCupertinoDialog(
                        context: context, 
                        builder: (_) => CupertinoAlertDialog(
                          content: Text(_generateErrorMessage(e)),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              child: Text('Ok'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                      );
                    }
                  );
          }
        }
      )
    );
    return Form(
      key: _formKey,
      child: Column(
        children: children,
      ),
    );
  }

  String _generateErrorMessage(PlatformException e) {
    if(e.code == 'ERROR_USER_NOT_FOUND') {
      return 'The User With The Specified Credentials Could Not Be Found.';
    } else if(e.code == 'ERROR_WRONG_PASSWORD') {
      return 'The Password Entered Is Incorrect.';
    }

    return e.code;
  }
}