class AuthCredentials {
  final String? username;
  final String email;
  final String? password;
  int? userId;

  AuthCredentials({
    this.username,
    required this.email,
    this.password,
    this.userId,
  });
}


/* import '../models/User.dart';

class AuthCredentials {
  final User user;

  AuthCredentials({required this.user});
}
 */