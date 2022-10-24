import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/profile/profile_event.dart';
import 'package:flutter_project/profile/profile_state.dart';

import '../models/User.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required User user}) : super(ProfileState(user: user));
}
