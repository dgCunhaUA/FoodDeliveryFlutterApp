import 'package:flutter_project/client/profile/profile_submission_status.dart';

import '../../models/Client.dart';

class ClientProfileState {
  final Client? client;
  bool isEditing;

  final ProfileSubmissionStatus profileSubmissionStatus;

  ClientProfileState({
    this.client,
    this.isEditing = false,
    this.profileSubmissionStatus = const InitialProfileSubmissionStatus(),
  });

  ClientProfileState copyWith(
      {Client? client,
      bool? isEditing,
      ProfileSubmissionStatus? profileSubmissionStatus}) {
    return ClientProfileState(
        client: client,
        isEditing: isEditing ?? this.isEditing,
        profileSubmissionStatus:
            profileSubmissionStatus ?? this.profileSubmissionStatus);
  }
}
