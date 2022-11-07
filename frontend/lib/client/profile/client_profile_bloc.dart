import 'dart:io';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/client/profile/client_profile_event.dart';
import 'package:flutter_project/client/profile/client_profile_state.dart';
import 'package:flutter_project/client/profile/profile_submission_status.dart';
import 'package:flutter_project/repositories/user_repository.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/Client.dart';

class ClientProfileBloc extends Bloc<ClientProfileEvent, ClientProfileState> {
  final UserRepository userRepo;
  File? photo;

  ClientProfileBloc({required Client client, required this.userRepo})
      : super(ClientProfileState(client: client)) {
    on<ClientProfileEvent>(
      (event, emit) async {
        print("evnet");
        print(event);
        if (event is EditProfileRequest) {
          _handleEditProfileRequest(event, emit);
        } else if (event is EditProfilePhotoRequest) {
          await _handleEditProfilePhotoRequest(event, emit);
        } else if (event is SaveProfileRequest) {
          await _handleSaveProfileRequest(event, emit);
        }
      },
      transformer: sequential(),
    );
  }

  void _handleEditProfileRequest(
      EditProfileRequest event, Emitter<ClientProfileState> emit) {
    emit(state.copyWith(
        client: state.client,
        profileEditingStatus: ProfileInitialEditingStatus()));
  }

  Future<void> _handleEditProfilePhotoRequest(
      EditProfilePhotoRequest event, Emitter<ClientProfileState> emit) async {
    final imagePicker = ImagePicker();
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.camera);
    photo = File(image!.path);

    emit(state.copyWith(
        client: state.client,
        image: photo,
        profileEditingStatus: ProfileEditingImageTaken()));
  }

  Future<void> _handleSaveProfileRequest(
      SaveProfileRequest event, Emitter<ClientProfileState> emit) async {
    try {
      emit(state.copyWith(profileEditingStatus: ProfileEditingSubmitting()));

      if (photo != null) {
        File newphoto = await userRepo.uploadClientPhoto(photo!);

        Client? updatedClient = await userRepo.getClient();

        emit(state.copyWith(
            client: updatedClient,
            image: newphoto,
            profileEditingStatus: ProfileEditingSubmissionSuccess()));
      } else {
        emit(
          state.copyWith(
            profileEditingStatus: ProfileEditingSubmissionSuccess(),
          ),
        );
      }
    } on Exception catch (e) {
      print(e);
      emit(state.copyWith(profileEditingStatus: SubmissionFailed(e)));
    }
  }
}
