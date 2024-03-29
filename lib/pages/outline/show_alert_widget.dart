import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ShowAlert extends StatelessWidget {
  final String title;
  final String content;
  final String buttonContent;
  final String secondButtonContent; //optional
  final Function onTap;
  final Function secondOnTap;

  ShowAlert({
    @required this.title,
    @required this.content,
    @required this.buttonContent,
    @required this.onTap,
    this.secondButtonContent,
    this.secondOnTap
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.blue,
        ),
      ),
      content: Container(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.error_outline, size: 30),
            const SizedBox(height: 20),
            Text(content),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(buttonContent, style: TextStyle( color: Colors.blue ),),
          onPressed: onTap, //reload page
        ),
        secondButtonContent != null && secondOnTap != null
            ? FlatButton(
                child: Text(secondButtonContent, style: TextStyle( color: Colors.blue ),),
                onPressed: secondOnTap, //reload page
              )
            : null,
      ],
    );
  }
}
