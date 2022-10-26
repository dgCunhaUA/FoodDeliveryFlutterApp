import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/client/profile/client_profile_event.dart';
import 'package:flutter_project/client/profile/client_profile_state.dart';
import 'package:flutter_project/client/profile/profile_submission_status.dart';

import '../../models/Client.dart';

class ClientProfileBloc extends Bloc<ClientProfileEvent, ClientProfileState> {
  ClientProfileBloc({required Client client})
      : super(ClientProfileState(client: client)) {
    on<ClientProfileEvent>(
      (event, emit) {
        if (event is EditProfileRequest) {
          _handleEditProfileRequest(event, emit);
        } else if (event is SaveProfileRequest) {
          _handleSaveProfileRequest(event, emit);
        }
      },
      transformer: sequential(),
    );
  }

  void _handleEditProfileRequest(
      EditProfileRequest event, Emitter<ClientProfileState> emit) {
    emit(state.copyWith(client: state.client, isEditing: true));
  }

  void _handleSaveProfileRequest(
      SaveProfileRequest event, Emitter<ClientProfileState> emit) {
    emit(state.copyWith(profileSubmissionStatus: ProfileUpdateSubmitting()));

    // get an new img
    print(state.client!.photo);

    // store the img

    // state submitted
  }
}
