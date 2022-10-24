part of 'signup_bloc.dart';

abstract class SignUpEvent {}

class SignUpUsernameChanged extends SignUpEvent {
  final String username;

  SignUpUsernameChanged({required this.username});
}

class SignUpEmailChanged extends SignUpEvent {
  final String email;

  SignUpEmailChanged({required this.email});
}

class SignUpPasswordChanged extends SignUpEvent {
  final String password;

  SignUpPasswordChanged({required this.password});
}

class SignUpAddressChanged extends SignUpEvent {
  final String address;

  SignUpAddressChanged({required this.address});
}

class SignUpVehicleChanged extends SignUpEvent {
  final String vehicle;

  SignUpVehicleChanged({required this.vehicle});
}

class SignUpSubmitted extends SignUpEvent {}
