import 'package:flutter/material.dart';

import 'models/User.dart';

abstract class SessionState {}

class UnknownSessionState extends SessionState {}

class Unauthenticated extends SessionState {}

class ClientAuthenticated extends SessionState {
  final User user;

  ClientAuthenticated({required this.user});
}

class RiderAuthenticated extends SessionState {
  //final Rider rider;
  //Authenticated({required this.rider});
  RiderAuthenticated();
}
