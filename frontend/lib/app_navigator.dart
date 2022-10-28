import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/screens/loading.dart';
import 'package:flutter_project/session_cubit.dart';
import 'package:flutter_project/session_state.dart';
import 'package:flutter_project/widgets/tabbar_menu.dart';

import 'auth/auth_navigator.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
      return Navigator(
        pages: [
          // Show login
          // Show loading screen
          if (state is UnknownSessionState)
            const MaterialPage(child: LoadingScreen()),

          // Show auth flow
          if (state is Unauthenticated)
            const MaterialPage(
              child: AuthNavigator(),
            ),

          // Show session flow
          if (state is ClientAuthenticated || state is RiderAuthenticated)
            const MaterialPage(child: TabBarMenu()),
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
