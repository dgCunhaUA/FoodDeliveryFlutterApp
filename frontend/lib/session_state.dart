import 'models/Rider.dart';
import 'models/Client.dart';

abstract class SessionState {}

class UnknownSessionState extends SessionState {}

class Unauthenticated extends SessionState {}

class ClientAuthenticated extends SessionState {
  final Client client;
  //final bool isDriver = false;

  ClientAuthenticated({required this.client});
}

class RiderAuthenticated extends SessionState {
  final Rider rider;
  //final bool isRider = true;

  RiderAuthenticated({required this.rider});
}
