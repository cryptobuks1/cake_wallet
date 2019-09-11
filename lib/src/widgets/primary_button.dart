import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cake_wallet/palette.dart';

class PrimaryButton extends StatelessWidget {

  final VoidCallback onPressed;
  final Color color;
  final Color borderColor;
  final String text;

  const PrimaryButton({
    @required this.onPressed,
    @required this.text,
    this.color = Palette.purple,
    this.borderColor = Palette.deepPink});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: double.infinity,
      height: 56.0,
      child: FlatButton(
        onPressed: onPressed,
        color: color,
        shape: RoundedRectangleBorder(side: BorderSide(color: borderColor), borderRadius: BorderRadius.circular(10.0)),
        child: Text(text, style: TextStyle(fontSize: 18.0)),
      )
    );
  }
}

class LoadingPrimaryButton extends StatelessWidget {

  final VoidCallback onPressed;
  final Color color;
  final Color borderColor;
  final bool isLoading;
  final String text;

  const LoadingPrimaryButton({
    @required this.onPressed,
    @required this.text,
    this.color = Palette.purple,
    this.borderColor = Palette.deepPink,
    this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: double.infinity,
      height: 56.0,
      child: FlatButton(
        onPressed: onPressed,
        color: color,
        shape: RoundedRectangleBorder(side: BorderSide(color: borderColor), borderRadius: BorderRadius.circular(10.0)),
        child: isLoading ? CupertinoActivityIndicator(animating: true) : Text(text, style: TextStyle(fontSize: 18.0)),
      )
    );
  }
}

class PrimaryIconButton extends StatelessWidget {

  final VoidCallback onPressed;
  final IconData iconData;
  final Color color;
  final Color borderColor;
  final Color iconColor;
  final String text;

  const PrimaryIconButton({
    @required this.onPressed,
    @required this.iconData,
    @required this.text,
    this.color = Palette.purple,
    this.borderColor = Palette.deepPink,
    this.iconColor = Colors.black
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        minWidth: double.infinity,
        height: 56.0,
        child: FlatButton(
          onPressed: onPressed,
          color: color,
          shape: RoundedRectangleBorder(side: BorderSide(color: borderColor), borderRadius: BorderRadius.circular(10.0)),
          child: Stack(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 28.0,
                    height: 56.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white
                    ),
                    child: Icon(iconData, color: iconColor, size: 20.0),
                  ),
                ],
              ),
              Container(
                height: 56.0,
                child: Center(
                  child: Text(text, style: TextStyle(fontSize: 18.0)),
                ),
              )
            ],
          ),
        )
    );
  }
}