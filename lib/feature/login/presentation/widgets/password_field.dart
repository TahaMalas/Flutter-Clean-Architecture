import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_germany/core/util/app_localizations.dart';
import 'package:flutter_test_germany/feature/login/presentation/bloc/login_bloc.dart';

class PasswordField extends StatelessWidget {
  final String error;

  const PasswordField({Key key, this.error}) : super(key: key);

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


            style: TextStyle(
              color: Colors.black,
              backgroundColor: Colors.white,
            ),
            obscureText: true,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: AppLocalizations.of(context).translate('password'),
              prefixIcon: Icon(Icons.lock_outline),
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              border: UnderlineInputBorder(),
              errorText: error,
            ),
            onChanged: BlocProvider.of<LoginBloc>(context).changePassword,
          ),
        ),
      ),
    );
  }
}
