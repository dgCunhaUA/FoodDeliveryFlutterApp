import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/auth/auth_cubit.dart';
import 'package:flutter_project/screens/register.dart';

import '../screens/login.dart';

class AuthNavigator extends StatelessWidget {
  const AuthNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return Navigator(
        pages: [
          // Show login
          if (state == AuthState.login) MaterialPage(child: LoginScreen()),

          // Allow push animation
          if (state == AuthState.signUp) ...[
            // Show Sign up
            const MaterialPage(child: SignUpScreen()),
          ]
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
