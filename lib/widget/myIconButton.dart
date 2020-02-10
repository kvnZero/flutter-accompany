import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  const MyIconButton({
    this.iconSize = 30.0,
    this.iconColor = Colors.black,
    @required this.icon,
    @required this.titleStyle,
    @required this.title,
    this.color,
    @required this.onPressed,
  });

  final double iconSize;
  final Color iconColor;
  final IconData icon;
  final Color color;
  final String title;
  final TextStyle titleStyle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.only(top: 10),
        onPressed: onPressed,
      child:  Column(
        children: <Widget>[
          Icon(icon,size: iconSize,color: iconColor,),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Text(title, style: titleStyle,),
          )
        ],
      )
    );
  }
}
