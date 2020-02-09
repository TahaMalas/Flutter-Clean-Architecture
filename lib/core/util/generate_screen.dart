import 'package:flutter/material.dart';
import 'package:flutter_test_germany/feature/login/presentation/pages/login_page.dart';

class GenerateScreen {
  static Route<dynamic> onGenerate(RouteSettings value) {
    String name = value.name;
    print("the name is $name");
    final args = value.arguments;
    switch (name) {
      case NameScreen.LOGIN:
        {
          return MaterialPageRoute(builder: (context) => LoginPage());
        }
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Error'),
          ),
          body: Center(
            child: Text('ERROR'),
          ),
        );
      },
    );
  }
}

class NameScreen {
  static const String LOGIN = "/";
}
