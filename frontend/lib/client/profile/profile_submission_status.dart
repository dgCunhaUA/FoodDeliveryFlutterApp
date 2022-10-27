abstract class ProfileEditSubmissionStatus {
  const ProfileEditSubmissionStatus();
}

class ProfileInitialStatus extends ProfileEditSubmissionStatus {
  const ProfileInitialStatus();
}

class ProfileInitialEditingStatus extends ProfileEditSubmissionStatus {}

class ProfileEditingImageTaken extends ProfileEditSubmissionStatus {}

class ProfileEditingSubmitting extends ProfileEditSubmissionStatus {}

class ProfileEditingSubmissionSuccess extends ProfileEditSubmissionStatus {}

class SubmissionFailed extends ProfileEditSubmissionStatus {
  final Exception exception;

  SubmissionFailed(this.exception);
}
