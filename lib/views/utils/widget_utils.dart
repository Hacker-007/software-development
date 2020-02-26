import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:software_development/views/utils/colors.dart';

class WidgetUtils {

  static Widget createSwitch(String title) {
    return _CustomSwitch(title);
  }

  static Future createYesOrNoDialog(BuildContext context, String title, String caption, { Function onConfirmation }) {
    return showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: Text('Delete Account'),
        content: Text('Are You Sure You Want To Delete Your Account? This Action Is Irreversible.'),
        actions: <Widget>[
          FlatButton(
            child: Text('Yes'),
            onPressed: onConfirmation != null ? onConfirmation : () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text('No'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  static Widget createForm(List<String> textFieldNames, String nameOfButton, { Map<String, Function> validatorMap, bool useDotsOnLast = false, Color color, path = '/' }) {
    return _CustomForm(
      textFieldNames,
      validatorMap != null ? validatorMap : new Map<String, Function>(),
      nameOfButton,
      useDotsOnLast: useDotsOnLast, 
      color: color == null ? colors['Dark Gray'] : color, 
      path: path
    );
  }

  static Widget createTextField(String caption, { bool isLast = false, bool showDots = false, String Function(String) validator }) {
    return Padding(
      padding: isLast ? const EdgeInsets.symmetric(vertical: 15.0) : const EdgeInsets.only(top: 15.0),
      child: SizedBox(
        width: 305.0,
        height: 72.0,
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: colors['Dark Gray'])
            ),
            helperText: caption,
            helperStyle: TextStyle(fontSize: 14.0),
          ),
          cursorColor: colors['Dark Gray'],
          style: TextStyle(fontSize: 20.0),
          validator: validator,
          obscureText: showDots,
        ),
      ),
    );
  }

  static Widget createButton(BuildContext context, String text, Color color, { String path, Function onPressed }) {
    return SizedBox(
      width: 225.0,
      child: OutlineButton(
        child: Text(
          text,
          style: TextStyle(color: color),
        ),
        onPressed: onPressed != null ? onPressed : () => Navigator.of(context).pushNamed(path),
        borderSide: BorderSide(color: color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        highlightedBorderColor: color,
      ),
    );
  }

  static Widget createLineSeparator({ double width = 225.0, double margin = 15.0 }) {
    return Container(
      width: width,
      child: Row(
        children: <Widget>[
          _createLine(),
          Text('or'),
          _createLine(),
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: margin),
    );
  }

  static Widget _createLine() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Divider(
          color: colors['Dark Gray'],
          thickness: 1.2,
        )
      ),
    );
  }
}

class _CustomSwitch extends StatefulWidget {
  String _title;

  _CustomSwitch(String title) {
    this._title = title;
  }

  @override
  _CustomSwitchState createState() => _CustomSwitchState(this._title);
}

class _CustomSwitchState extends State<_CustomSwitch> {
  String _title;
  bool _isOn;

  _CustomSwitchState(String title) {
    this._title = title;
    this._isOn = false;
  }

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: ListTile(
        title: Text(this._title),
        trailing: Transform.scale(
          scale: 0.8,
          child: CupertinoSwitch(
            value: this._isOn,
            onChanged: (value) {
              // Update Shared Preferences
              setState(() => this._isOn = value);
            },
            activeColor: colors['Green'],
          ),
        ),
        onTap: () => setState(() => this._isOn = !this._isOn),
        contentPadding: EdgeInsets.only(left: 20.0, right: 40.0),
      ),
    );
  }
}

class _CustomForm extends StatefulWidget {
  List<String> _textFieldNames;
  Map<String, Function> _validatorMap;
  bool _useDotsOnLast;
  String _nameOfButton;
  Color _color;
  String _path;

  _CustomForm(List<String> textFieldNames, Map<String, Function> validatorMap, String nameOfButton, { bool useDotsOnLast = false, Color color, String path = '/' }) {
    this._textFieldNames = textFieldNames;
    this._validatorMap = validatorMap;
    this._useDotsOnLast = useDotsOnLast;
    this._nameOfButton = nameOfButton;
    this._color = color;
    this._path = path;
  }

  @override
  _CustomFormState createState() {
    return _CustomFormState(
      this._textFieldNames,
      this._validatorMap,
      this._useDotsOnLast, 
      this._nameOfButton, 
      this._color, 
      this._path
    );
  }
}

class _CustomFormState extends State<_CustomForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> _textFieldNames;
  Map<String, Function> _validatorMap;
  bool _useDotsOnLast;
  String _nameOfButton;
  Color _color;
  String _path;

  _CustomFormState(List<String> textFieldNames, Map<String, Function> validatorMap, bool useDotsOnLast, String nameOfButton, Color color, String path) {
    this._textFieldNames = textFieldNames;
    this._validatorMap = validatorMap;
    this._useDotsOnLast = useDotsOnLast;
    this._nameOfButton = nameOfButton;
    this._color = color;
    this._path = path;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = new List<Widget>();
    for(int i = 0; i < this._textFieldNames.length; i++) {
      String name = this._textFieldNames.elementAt(i);
      children.add(
        WidgetUtils.createTextField(
          name,
          isLast: i == this._textFieldNames.length - 1,
          showDots: i == this._textFieldNames.length - 1 && this._useDotsOnLast,
          validator: this._validatorMap.containsKey(name) ? this._validatorMap[name] : (text) => text.isEmpty ? 'Please Enter A ${this._textFieldNames.elementAt(i)}' : null,
        )
      );
    }

    children.add(
      WidgetUtils.createButton(
        context, 
        this._nameOfButton, 
        this._color, 
        onPressed: () {
          if(_formKey.currentState.validate()) {
            print('Valid');
            Navigator.of(context).pushNamed(_path);
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
}