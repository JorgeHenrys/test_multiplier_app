import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_multiplier_app/src/features/auth/auth.dart';

class MultiplierApp extends StatelessWidget {
  const MultiplierApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'Multiplier App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Mulish', primarySwatch: Colors.blue),
      home: const AuthPage(),
    );
  }
}
