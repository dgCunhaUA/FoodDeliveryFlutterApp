part of 'signup_bloc.dart';

class SignUpState {
  final String username;
  final String email;
  final String password;
  final String address;
  final String vehicle;

  final FormSubmissionStatus formStatus;

  SignUpState({
    this.username = '',
    this.email = '',
    this.password = '',
    this.address = '',
    this.vehicle = '',
    this.formStatus = const InitialFormStatus(),
  });

  SignUpState copyWith({
    String? username,
    String? email,
    String? password,
    String? address,
    String? vehicle,
    FormSubmissionStatus? formStatus,
  }) {
    return SignUpState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      vehicle: vehicle ?? this.vehicle,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
