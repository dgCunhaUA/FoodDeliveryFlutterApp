class AuthCredentials {
  final String? username;
  final String email;
  final String? password;
  int? userId;
  int? riderId;

  AuthCredentials({
    this.username,
    required this.email,
    this.password,
    this.userId,
    this.riderId,
  });
}


/* import '../models/User.dart';

class AuthCredentials {
  final User user;

  AuthCredentials({required this.user});
}
 */