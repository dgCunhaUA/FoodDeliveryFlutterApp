import 'dart:io';

import 'package:flutter_project/client/profile/profile_submission_status.dart';

import '../../models/Client.dart';

class ClientProfileState {
  final Client client;
  final ProfileEditSubmissionStatus profileEditingStatus;
  final File? image;

  ClientProfileState(
      {required this.client,
      this.profileEditingStatus = const ProfileInitialStatus(),
      this.image});

  ClientProfileState copyWith(
      {Client? client,
      ProfileEditSubmissionStatus? profileEditingStatus,
      File? image}) {
    return ClientProfileState(
        client: client ?? this.client,
        profileEditingStatus: profileEditingStatus ?? this.profileEditingStatus,
        image: image ?? this.image);
  }
}
