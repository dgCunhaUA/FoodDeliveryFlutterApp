import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/auth/auth_cubit.dart';
import 'package:flutter_project/client/cart/cart_bloc.dart';
import 'package:flutter_project/client/orders/orders_bloc.dart';
import 'package:flutter_project/repositories/user_repository.dart';
import 'package:flutter_project/rider/orders/orders_bloc.dart';
import 'package:flutter_project/session_cubit.dart';

import 'app_navigator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodDelivery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.green,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white)),
        ),
        bottomSheetTheme:
            BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
      ),
      home: RepositoryProvider(
        create: (context) => UserRepository(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  SessionCubit(userRepo: context.read<UserRepository>()),
            ),
            BlocProvider(
              create: (context) =>
                  AuthCubit(sessionCubit: context.read<SessionCubit>()),
            ),
            BlocProvider(
              create: (context) =>
                  CartBloc(userRepo: context.read<UserRepository>()),
            ),
            BlocProvider(
              create: (context) =>
                  OrdersBloc(userRepo: context.read<UserRepository>()),
            ),
            BlocProvider(
              create: (context) =>
                  RiderOrdersBloc(userRepo: context.read<UserRepository>()),
            ),
          ],
          child: const AppNavigator(),
        ),
      ),
    );
  }
}
