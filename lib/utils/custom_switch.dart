import 'package:Software_Development/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final String title;

  CustomSwitch({Key key, @required this.title}) : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool _isOn;
  
  @override
  void initState() {
    super.initState();
    this._isOn = false;
  }

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: ListTile(
        title: Text(widget.title),
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