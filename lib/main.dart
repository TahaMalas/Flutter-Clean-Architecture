import 'package:flutter/material.dart';
import 'package:flutter_test_germany/injection.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(App());
}
