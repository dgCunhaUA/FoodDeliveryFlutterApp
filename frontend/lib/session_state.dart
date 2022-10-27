import 'models/Rider.dart';
import 'models/Client.dart';

abstract class SessionState {}

class UnknownSessionState extends SessionState {}

class Unauthenticated extends SessionState {}

class ClientAuthenticated extends SessionState {
  final Client client;

  ClientAuthenticated({required this.client});
}

class RiderAuthenticated extends SessionState {
  final Rider rider;

  RiderAuthenticated({required this.rider});
}
