import 'package:flutter_project/auth/form_submission_status.dart';

import '../models/User.dart';

class ProfileState {
  final User user;

  ProfileState({required this.user});

  ProfileState copyWith({User? user}) {
    return ProfileState(user: user ?? this.user);
  }
}
