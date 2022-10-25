part of 'signup_bloc.dart';

class SignUpState {
  final String username;
  final String email;
  final String password;
  final String address;
  final String vehicle;
  final bool rider;

  final FormSubmissionStatus formStatus;

  SignUpState({
    this.username = '',
    this.email = '',
    this.password = '',
    this.address = '',
    this.vehicle = '',
    this.rider = false,
    this.formStatus = const InitialFormStatus(),
  });

  SignUpState copyWith({
    String? username,
    String? email,
    String? password,
    String? address,
    String? vehicle,
    bool? rider,
    FormSubmissionStatus? formStatus,
  }) {
    return SignUpState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      vehicle: vehicle ?? this.vehicle,
      rider: rider ?? this.rider,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
