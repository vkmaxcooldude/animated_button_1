//Author: Vishal Kumar
//Challenge from: https://dribbble.com/shots/6363045-Daily-UI-Challenge-054-Confirmation
import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {

  final String initialText, finalText;
  ButtonStyle buttonStyle;
  final IconData iconData;
  final double iconSize;
  final Duration animationDuration;
  final Function onTap;


  AnimatedButton({
    this.initialText, 
    this.finalText, 
    this.buttonStyle, 
    this.iconData, 
    this.animationDuration, 
    this.iconSize,
    this.onTap
    });

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> with TickerProviderStateMixin {

  AnimationController _controller;
  ButtonState _currentState;
  Duration _smallDuration;
  Animation<double> _scaleFinalTextAnimation;
  double finalFontSize;

  @override
  void initState() {
    super.initState();
    finalFontSize = widget.buttonStyle.finalTextStyle.fontSize;
    _controller = AnimationController(vsync: this, duration: widget.animationDuration);
    _currentState = ButtonState.SHOW_ONLY_TEXT;
    _smallDuration = Duration(milliseconds: (widget.animationDuration.inMilliseconds * 0.25).round());
    _controller.addListener((){
      double _controllerValue = _controller.value;
      if(_controllerValue < 0.25){ 
        setState(() {
        _currentState = ButtonState.SHOW_ONLY_ICON; 
        });
      }
      else if (_controllerValue > 0.75){
        setState(() {
          _currentState = ButtonState.SHOW_TEXT_ICON;
          widget.buttonStyle.finalTextStyle = TextStyle(
            color: Color(0xff028f1d),
            fontSize: finalFontSize * _controllerValue,
          );
        });
      }
    });

    _controller.addStatusListener((currentStatus){
      if(currentStatus == AnimationStatus.completed){
        return widget.onTap();
      }
    });

    _scaleFinalTextAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
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
          _controller.forward();
        },
        child: AnimatedContainer(
          duration: _smallDuration,
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
          child: AnimatedSize(
              vsync: this,
              duration: _smallDuration,
              curve: Curves.easeIn,
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
                (_currentState == ButtonState.SHOW_TEXT_ICON) ? SizedBox(width: 25.0,) : SizedBox(),
                getTextWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
    Widget getTextWidget(){
    if(_currentState == ButtonState.SHOW_ONLY_TEXT){
     return Text(
        widget.initialText,
        style: widget.buttonStyle.initialTextStyle,
      );
    }
    else if(_currentState == ButtonState.SHOW_ONLY_ICON){
      return SizedBox();
    }
    else{
      return ScaleTransition(
        scale: _scaleFinalTextAnimation,
          child: Text(
          widget.finalText,
          style: widget.buttonStyle.finalTextStyle,
        ),
      );
    }
  }
}


class ButtonStyle {
  TextStyle initialTextStyle, finalTextStyle;
  final Color primaryColor, secondaryColor;
  final double elevation, borderRadius;

  ButtonStyle({this.primaryColor, this.secondaryColor, this.initialTextStyle, this.finalTextStyle, this.elevation, this.borderRadius});
}

enum ButtonState{
  SHOW_ONLY_TEXT,
  SHOW_ONLY_ICON,
  SHOW_TEXT_ICON
}