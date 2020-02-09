import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_germany/core/util/app_localizations.dart';
import 'package:flutter_test_germany/feature/login/presentation/bloc/login_bloc.dart';

class EmailField extends StatelessWidget {
  final String error;

  const EmailField({Key key, this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Theme(
          data: ThemeData(
            canvasColor: Colors.black,
            primaryColor: Colors.black,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
          ),
          child: TextField(
            cursorColor: Colors.black,
            style: TextStyle(
              color: Colors.black,
              backgroundColor: Colors.white,
            ),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              fillColor: Colors.white,
              border: UnderlineInputBorder(),
              filled: true,
              hintText: AppLocalizations.of(context).translate('email'),
              prefixIcon: Icon(Icons.email),
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              errorText: error,
            ),
            onChanged: BlocProvider.of<LoginBloc>(context).changeEmail,
          ),
        ),
      ),
    );
  }
}
