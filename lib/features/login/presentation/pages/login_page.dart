import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:task_management/config/theme/app_theme_text_style.dart';
import 'package:task_management/core/mixin/snack_bar_mixin.dart';
import 'package:task_management/features/login/presentation/bloc/login_bloc.dart';
import 'package:task_management/features/login/presentation/widgets/clipper.dart';
import 'package:task_management/features/login/presentation/widgets/clipper_2.dart';

class LoginPage extends StatefulWidget {
  static const id = 'LoginPage';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SnackBarMixin {
  TextEditingController emailCtl = TextEditingController();
  TextEditingController passwordCtl = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _bloc = GetIt.I.get<LoginBloc>();

  @override
  void dispose() {
    emailCtl.dispose();
    passwordCtl.dispose();
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>.value(
      value: _bloc,
      child: BlocListener<LoginBloc, LoginState>(
        bloc: _bloc,
        listenWhen: (previous, current) {
          return previous != current;
        },
        listener: (context, state) {
          if (state is SnackBarStateError) {
            showErrorSnackBar(context, message: state.message);
          } else if (state is SnackBarStateSuccess) {
            showSuccessSnackBarAndGoToMainMenu(
              context,
              message: state.message,
            );
          } else {
            removeSnackBar(context);
          }
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    CustomPaint(
                      size: Size(MediaQuery.of(context).size.width, 300),
                      painter: RPSCustomPainter(),
                    ),
                    Positioned(
                      top: 16,
                      right: -5,
                      child: CustomPaint(
                        size: Size(MediaQuery.of(context).size.width, 300),
                        painter: RPCustomPainter(),
                      ),
                    ),
                    Positioned(
                      top: 220,
                      left: 30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            style: AppThemeTextStyle.museoSans700w400.copyWith(
                              fontSize: 30,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Please sign in to continue.',
                            style: AppThemeTextStyle.museoSans500w400.copyWith(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        _getEmailWidget(context),
                        const SizedBox(
                          height: 25,
                        ),
                        _getPasswordWidget(context),
                        const SizedBox(
                          height: 50,
                        ),
                        InkWell(
                          onTap: () => _userLogin(context),
                          child: Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: const LinearGradient(colors: [
                                Color(0xfff7b858),
                                Color(0xfffca148),
                              ]),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'LOGIN',
                                  style: AppThemeTextStyle.museoSans500w400
                                      .copyWith(
                                    fontSize: 17,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 150,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getEmailWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(3, 3),
            blurRadius: 6,
            color: Colors.grey.shade400,
          ),
        ],
      ),
      child: TextFormField(
        controller: emailCtl,
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(
            top: 14,
          ),
          prefixIcon: Icon(Icons.email_outlined),
          hintText: 'Enter your email',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Enter your email";
          }

          if (!RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value)) {
            return "Enter correct email";
          }

          return null;
        },
      ),
    );
  }

  Widget _getPasswordWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(3, 3),
            blurRadius: 6,
            color: Colors.grey.shade400,
          ),
        ],
      ),
      child: TextFormField(
        obscureText: true,
        controller: passwordCtl,
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(
            top: 14,
          ),
          prefixIcon: Icon(Icons.lock_outline_rounded),
          hintText: 'Enter your password',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Enter your password";
          }

          if (value.length < 8) {
            return "Password should have 8 Character";
          }

          return null;
        },
      ),
    );
  }

  void _userLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _bloc.add(
        LoginUser(emailCtl.text, passwordCtl.text),
      );
    }
  }

  void showSuccessSnackBarAndGoToMainMenu(BuildContext context,
      {String? message}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            content: Text(message ?? ''),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 1),
          ),
        )
        .closed
        // .then((_) => goToMainMenu(context));
        .then(
          (_) => {},
        );
  }

  // void goToMainMenu(BuildContext context) {
  //   Navigator.of(context).pushAndRemoveUntil(
  //       MaterialPageRoute(builder: (context) => const AppRouter()),
  //       (route) => false);
  // }
}
