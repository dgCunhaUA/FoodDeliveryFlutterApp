import 'dart:io';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/client/profile/profile_submission_status.dart';
import 'package:flutter_project/repositories/user_repository.dart';
import 'package:flutter_project/rider/profile/rider_profile_event.dart';
import 'package:flutter_project/rider/profile/rider_profile_state.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/Rider.dart';

class RiderProfileBloc extends Bloc<RiderProfileEvent, RiderProfileState> {
  final UserRepository userRepo;
  late File photo;

  RiderProfileBloc({required Rider rider, required this.userRepo})
      : super(RiderProfileState(rider: rider)) {
    on<RiderProfileEvent>(
      (event, emit) async {
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
      EditProfileRequest event, Emitter<RiderProfileState> emit) {
    emit(state.copyWith(
        rider: state.rider,
        profileEditingStatus: ProfileInitialEditingStatus()));
  }

  Future<void> _handleEditProfilePhotoRequest(
      EditProfilePhotoRequest event, Emitter<RiderProfileState> emit) async {
    final imagePicker = ImagePicker();
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.camera);
    photo = File(image!.path);

    print(photo.path);

    emit(state.copyWith(
        rider: state.rider,
        image: photo,
        profileEditingStatus: ProfileEditingImageTaken()));
  }

  Future<void> _handleSaveProfileRequest(
      SaveProfileRequest event, Emitter<RiderProfileState> emit) async {
    try {
      emit(state.copyWith(profileEditingStatus: ProfileEditingSubmitting()));
      File newphoto = await userRepo.uploadRiderPhoto(photo);

      Rider? updatedRider = await userRepo.getRider();

      emit(state.copyWith(
          rider: updatedRider,
          image: newphoto,
          profileEditingStatus: ProfileEditingSubmissionSuccess()));
    } on Exception catch (e) {
      print(e);
      emit(state.copyWith(profileEditingStatus: SubmissionFailed(e)));
    }
  }
}
