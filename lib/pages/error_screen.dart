import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 150, horizontal: 50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FittedBox(
                child: Image.asset(
                  'assets/img/404.png',
                ),
              ),
              Text('Oops.. ' + tr("generic_error")),
              FlatButton(
                color: Colors.blue,
                child: Text(tr("error_page_button"), style: TextStyle(color: Colors.white)),
                onPressed: () => Navigator.of(context).pushReplacementNamed('/'),
              )
            ],
          ),
        ),
      ),
    );
  }
}