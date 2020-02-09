import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_germany/core/util/app_localizations.dart';
import 'package:flutter_test_germany/core/util/constants.dart';
import 'package:flutter_test_germany/core/util/future_version.dart';
import 'package:flutter_test_germany/feature/login/presentation/bloc/login_bloc.dart';
import 'package:flutter_test_germany/feature/login/presentation/bloc/login_state.dart';
import 'package:flutter_test_germany/feature/login/presentation/widgets/email_field.dart';
import 'package:flutter_test_germany/feature/login/presentation/widgets/login_button.dart';
import 'package:flutter_test_germany/feature/login/presentation/widgets/password_field.dart';
import 'package:flutter_test_germany/feature/login/presentation/widgets/remember_me_check_box.dart';
import 'package:flutter_test_germany/injection.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _bloc = sl<LoginBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (_) => _bloc,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            'Flutter Clean Architecture',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return BlocBuilder(
              bloc: _bloc,
              builder: (context, LoginState state) {
                print('the state is $state');
                if (state.isSuccess) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showDialog(
                        context: context, builder: (_) => FutureVersion());
                    _bloc.resetSuccess();
                  });
                }
                return Stack(
                  children: <Widget>[
                    Center(
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          EmailField(
                            error: state.isEmailError
                                ? AppLocalizations.of(context).translate(
                                    loginTexts[LoginTexts.INVALID_EMAIL])
                                : null,
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                          ),
                          PasswordField(
                            error: state.isPasswordError
                                ? AppLocalizations.of(context).translate(
                                    loginTexts[LoginTexts.INVALID_PASSWORD],
                                  )
                                : null,
                          ),
                          RememberMeCheckBox(
                            isChecked: state.isRememberMe,
                          ),
                          LoginButton(isValid: state.isEnabled),
                        ],
                      ),
                    ),
                    Center(
                      child: state.isLoading
                          ? CircularProgressIndicator()
                          : Container(),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
