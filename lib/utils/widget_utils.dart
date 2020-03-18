import 'package:Software_Development/utils/custom_form.dart';
import 'package:Software_Development/utils/custom_search_bar.dart';
import 'package:Software_Development/utils/custom_stepper.dart';
import 'package:Software_Development/utils/custom_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Software_Development/utils/colors.dart';

class WidgetUtils {

  static Widget createStepper({ @required List<Widget> steps, @required int currentStep, @required bool autoCheckLast }) {
    return CustomStepper(
      steps: steps,
      currentStep: currentStep,
      autoCheckLast: autoCheckLast ?? false,
    );
  }

  static Widget createSwitch(String title) {
    return CustomSwitch(title: title);
  }

  static Future createYesOrNoDialog(BuildContext context,
                                    String title, 
                                    String caption, 
                                    { Function onConfirmation }
                                   ) {
    return showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: Text('Delete Account'),
        content: Text('Are You Sure You Want To Delete Your Account? This Action Is Irreversible.'),
        actions: <Widget>[
          FlatButton(
            child: Text('Yes'),
            onPressed: onConfirmation ?? () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text('No'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  static Widget createForm(List<String> textFieldNames, 
                           String nameOfButton,
                           { 
                             Map<String, Function> validatorMap, 
                             Function onPressed,
                             List<int> indexes,
                             bool useDotsOnLast = false, 
                             Color color, 
                             path = '/'
                           }
                          ) {
    return CustomForm(
      textFieldNames: textFieldNames,
      validatorMap: validatorMap ?? Map<String, Function>(),
      nameOfButton: nameOfButton,
      onPressed: onPressed ?? (context) => Future.value(null),
      indexes: indexes ?? List(),
      useDotsOnLast: useDotsOnLast, 
      color: color ?? colors['Dark Gray'], 
      path: path
    );
  }

  static Widget createTextField(String caption, 
                                { 
                                  bool isLast = false, 
                                  bool showDots = false, 
                                  TextEditingController controller, 
                                  String Function(String) validator 
                                }
                               ) {
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
          style: TextStyle(fontSize: 16.0),
          validator: validator,
          obscureText: showDots,
          controller: controller,
        ),
      ),
    );
  }

  static Widget createRestaurantCard(String name, double rating, { String imageLocation, @required void Function(bool) onPressed }) {
    if(imageLocation == null) {
      return ChoiceChip(
        backgroundColor: Colors.grey[50],
        labelPadding: EdgeInsets.only(left: 5.0),
        selected: false,
        onSelected: onPressed,
        elevation: 1.3,
        avatar: CircleAvatar(
          backgroundColor: Colors.grey[50],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Icon(
                Icons.star,
                color: Colors.yellow,
                size: 10.0
              ),
              Text(
                '$rating',
                style: TextStyle(
                  fontSize: 10.0,
                  color: colors['Purple'],
                ),
              )
            ],
          ),
        ),
        label: Text(
          name,
          style: TextStyle(
            color: colors['Purple'],
            fontSize: 14.0,
          ),
        ),
      );  
    } else {
      return GestureDetector(
        onTap: () => onPressed(true),
        child: Card(
          elevation: 1.3,
          color: Colors.grey[50],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(21.0)
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(21.0), topRight: Radius.circular(21.0)),
                  child: Image.asset(
                    imageLocation,
                    width: 200.0,
                  ),
                ),
                Container(
                  width: 200.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        name,
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: colors['Purple'],
                          fontSize: 14.0,
                        ),
                      ),
                      RawChip(
                        label: CircleAvatar(
                          radius: 12.0,
                          backgroundColor: Colors.grey[50],
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 10.0
                              ),
                              Text(
                                '$rating',
                                style: TextStyle(
                                  fontSize: 10.0,
                                  color: colors['Purple'],
                                ),
                              )
                            ],
                          ),
                        ),
                        backgroundColor: Colors.grey[50],
                        elevation: 1.3,
                      ), 
                    ]
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  static Widget createSearchBar({ @required String description, @required List<Map<String, dynamic>> list, @required String field, @required Widget content, List<Widget> actions, Widget bottomNavigation, void Function(String) onPressed }) {
    return CustomSearchBar(
      description: description,
      list: list,
      field: field,
      content: content,
      actions: actions,
      bottomNavigation: bottomNavigation,
      onPressed: onPressed,
    );
  }

  static Widget createIconButton(BuildContext context, Icon icon, String path, { double iconSize = 24.0 }) {
    return IconButton(
      icon: icon,
      iconSize: iconSize,
      color: colors['Green'],
      onPressed: () => Navigator.of(context).pushNamed('/$path'),
    );
  }

  static Widget createButton(BuildContext context, 
                             String text, 
                             Color color, 
                             { 
                               String path, 
                               Function onPressed 
                             }
                            ) {
    return SizedBox(
      width: 225.0,
      child: OutlineButton(
        child: Text(
          text,
          style: TextStyle(color: color),
        ),
        onPressed: onPressed ?? () => Navigator.of(context).pushNamed(path),
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
          createLine(),
          Text('or'),
          createLine(),
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: margin),
    );
  }

  static Widget createLine([ double margin = 4.0 ]) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: margin),
        child: Divider(
          color: colors['Dark Gray'],
          thickness: 1.2,
        )
      ),
    );
  }
}