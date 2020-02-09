import 'package:flutter/material.dart';
import 'package:flutter_test_germany/core/util/app_localizations.dart';

class FutureVersion extends StatefulWidget {
  @override
  _FutureVersionState createState() => _FutureVersionState();
}

class _FutureVersionState extends State<FutureVersion> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      backgroundColor: Color.fromRGBO(83, 84, 98, 1),
      title: Text(
        AppLocalizations.of(context).translate('future_version').toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Regular',
          fontSize: 20,
        ),
      ),
      actions: <Widget>[
        Center(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 40,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
                border: new Border.all(
                  color: Colors.white,
                  width: 1.0,
                ),
              ),
              child: Center(
                child: Text(
                  AppLocalizations.of(context).translate('close').toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Regular',
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
      content: Text(
        AppLocalizations.of(context).translate('future_version_content'),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Regular',
          fontSize: 15,
        ),
      ),
    );
  }
}
