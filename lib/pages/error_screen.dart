import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FittedBox(
                child: Image.asset(
                  'assets/img/404.png',
                ),
              ),
              const SizedBox(height: 10),
              Text('Oops.. ' + tr("generic_error")),
              const SizedBox(height: 20),
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