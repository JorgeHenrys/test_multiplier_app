import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_multiplier_app/src/core/core.dart';
import 'package:test_multiplier_app/src/features/auth/auth.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  final AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AuthCubit>(
        create: (context) => injector(),
        child: AuthContent(
          formKey: _formKey,
          autovalidate: _autovalidate,
          email: _email,
          password: _password,
          loading: _loading,
        ),
      ),
    );
  }
}
