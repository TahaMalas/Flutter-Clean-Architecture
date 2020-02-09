import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_germany/core/util/app_localizations.dart';
import 'package:flutter_test_germany/core/util/constants.dart';
import 'package:flutter_test_germany/feature/login/presentation/bloc/login_bloc.dart';

class LoginButton extends StatelessWidget {
  final bool isValid;

  const LoginButton({Key key, this.isValid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: isValid
          ? () {
              BlocProvider.of<LoginBloc>(context).onLoginPressed('token');
            }
          : null,
      child: Text(
        AppLocalizations.of(context)
            .translate(loginTexts[LoginTexts.LOGIN]),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isValid ? Colors.black : Colors.black26,
          fontSize: 25,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
  }
}
