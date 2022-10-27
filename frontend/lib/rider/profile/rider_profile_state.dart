import 'dart:io';

import 'package:flutter_project/client/profile/profile_submission_status.dart';

import '../../models/Rider.dart';

class RiderProfileState {
  final Rider rider;
  final ProfileEditSubmissionStatus profileEditingStatus;
  final File? image;

  RiderProfileState(
      {required this.rider,
      this.profileEditingStatus = const ProfileInitialStatus(),
      this.image});

  RiderProfileState copyWith(
      {Rider? rider,
      ProfileEditSubmissionStatus? profileEditingStatus,
      File? image}) {
    return RiderProfileState(
        rider: rider ?? this.rider,
        profileEditingStatus: profileEditingStatus ?? this.profileEditingStatus,
        image: image ?? this.image);
  }
}
