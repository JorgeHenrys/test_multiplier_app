import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_multiplier_app/src/core/core.dart';
import 'package:test_multiplier_app/src/features/auth/auth.dart';

class AuthContent extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController email;
  final TextEditingController password;
  final AutovalidateMode autovalidate;
  final bool loading;

  const AuthContent({
    super.key,
    required this.formKey,
    required this.email,
    required this.password,
    required this.autovalidate,
    required this.loading,
  });

  void showSnackBar(BuildContext context) {
    const snackBar = SnackBar(
      elevation: 10,
      content: Row(
        children: [
          Icon(Icons.warning_amber_outlined),
          SizedBox(width: 20),
          Text(
            'Email ou senha incorreto',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.deepOrangeAccent,
      padding: EdgeInsets.all(20),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.error) {
          showSnackBar(context);
        }
        if (state.status == AuthStatus.success) {
          Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return Container();
              },
            ),
            (_) => false,
          );
        }
      },
      child: SingleChildScrollView(
        child: SizedBox(
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 26, left: 24, right: 24),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/multiplier.png',
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Bem-Vindo ao "App"',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 20,
                          fontFamily: 'Mulish',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'faça login para acessar sua conta',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 12,
                          fontFamily: 'Mulish',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Column(
                        children: [
                          BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                              return Form(
                                autovalidateMode: autovalidate,
                                key: formKey,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 32),
                                    MultiplierBaseInput(
                                      disabled: loading,
                                      label: 'E-mail',
                                      controller: email,
                                      validator: (String? value) =>
                                          emailValidator(
                                            value,
                                            'insira um email válido',
                                          ),
                                    ),
                                    const SizedBox(height: 16),
                                    MultiplierPasswordInput(
                                      disabled: loading,
                                      label: 'Senha',
                                      controller: password,
                                      validator: (String? value) =>
                                          requiredFieldValidator(
                                            value,
                                            'insira uma senha válida',
                                          ),
                                    ),
                                    const SizedBox(height: 32),
                                    MultiplierButton(
                                      label: 'Entrar',
                                      type: MultiplierButtonTypes.primary,
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          BlocProvider.of<AuthCubit>(
                                            context,
                                          ).signInAuth(
                                            email.text,
                                            password.text,
                                          );
                                        }
                                      },
                                      isFullWidth: true,
                                      loading:
                                          state.status == AuthStatus.loading,
                                      disabled: loading,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 32),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 220,
                                decoration: const ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      strokeAlign: BorderSide.strokeAlignCenter,
                                      color: Color(0xFFDDE4EE),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 32),

                          MultiplierButton(
                            label: "Entrar com Google",
                            onPressed: () {},
                            type: MultiplierButtonTypes.secondary,
                            bordercolor: Colors.blueGrey,
                            color: Colors.blueGrey,
                            icon: Image.asset(
                              'assets/icons/google-icon.png',
                              width: 25,
                              height: 25,
                            ),
                            isFullWidth: true,
                          ),

                          const SizedBox(height: 34),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
