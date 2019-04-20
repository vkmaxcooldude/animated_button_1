//Start from 24:00 https://www.youtube.com/watch?v=l0VccGP-ygA
import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {

  final String initialText, finalText;
  final ButtonStyle buttonStyle;
  final IconData iconData;
  final double iconSize;
  final Duration animationDuration;

  AnimatedButton({this.initialText, this.finalText, this.buttonStyle, this.iconData, this.animationDuration, this.iconSize});

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> with TickerProviderStateMixin {

  AnimationController _controller;
  ButtonState _currentState;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _currentState = ButtonState.SHOW_ONLY_TEXT;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: widget.buttonStyle.elevation,
      borderRadius: BorderRadius.all(Radius.circular(widget.buttonStyle.borderRadius)),
      child: InkWell(
        onTap: (){
          setState(() {
            _currentState = ButtonState.SHOW_ONLY_ICON;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 1000),
          height: widget.iconSize + 16.0,
          decoration: BoxDecoration(
            color: (_currentState == ButtonState.SHOW_ONLY_TEXT) ? widget.buttonStyle.primaryColor : widget.buttonStyle.secondaryColor,
            border: Border.all(
              color: (_currentState == ButtonState.SHOW_ONLY_TEXT) ? Colors.transparent : widget.buttonStyle.primaryColor,
            ),
           borderRadius: BorderRadius.all(Radius.circular(widget.buttonStyle.borderRadius)),
          ),
          //color: Color(0xff028f1d),
          padding: EdgeInsets.symmetric(horizontal: (_currentState == ButtonState.SHOW_ONLY_TEXT)? 48.0 : 16.0 , vertical: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              (_currentState == ButtonState.SHOW_ONLY_ICON || _currentState == ButtonState.SHOW_TEXT_ICON) ?
              Icon(
                widget.iconData,
                color: widget.buttonStyle.primaryColor,
                size: widget.iconSize,
              )
                  : SizedBox(),
              (_currentState == ButtonState.SHOW_ONLY_TEXT) ?
              Text(
                widget.initialText,
                style: widget.buttonStyle.initialTextStyle,
              )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonStyle {
  final TextStyle initialTextStyle, finalTextStyle;
  final Color primaryColor, secondaryColor;
  final double elevation, borderRadius;

  ButtonStyle({this.primaryColor, this.secondaryColor, this.initialTextStyle, this.finalTextStyle, this.elevation, this.borderRadius});
}

enum ButtonState{
  SHOW_ONLY_TEXT,
  SHOW_ONLY_ICON,
  SHOW_TEXT_ICON
}