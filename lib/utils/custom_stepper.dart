import 'package:Software_Development/utils/colors.dart';
import 'package:Software_Development/utils/widget_utils.dart';
import 'package:flutter/material.dart';

class CustomStepper extends StatefulWidget {
  final List<Widget> steps;
  final int currentStep;
  final bool autoCheckLast;
  final Widget appBar;

  CustomStepper({Key key, @required this.steps, @required this.currentStep, this.autoCheckLast, this.appBar}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {

  @override
  Widget build(BuildContext context) {
    List<Widget> dots = [];
    for(int i = 0; i < widget.steps.length; i++) {
      dots.add(
        Padding(
          padding: i == 0 ? const EdgeInsets.only(top: 16.0, bottom: 16.0, left: 16.0) : 
                            i == widget.steps.length - 1 ? const EdgeInsets.only(top: 16.0, bottom: 16.0, right: 16.0) : 
                                                          const EdgeInsets.only(top: 16.0, bottom: 16.0),
          child: Icon(
            (i < widget.currentStep || (widget.currentStep == widget.steps.length - 1 && widget.autoCheckLast)) ? Icons.check_circle : Icons.radio_button_unchecked,
            color: colors['Green'],
          ),
        )
      );

      if(i != widget.steps.length - 1) {
        dots.add(WidgetUtils.createLine());
      }
    }

    return Scaffold(
      appBar: this.widget.appBar,
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: widget.steps.elementAt(widget.currentStep),
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: dots,
      ),
    );
  }
}