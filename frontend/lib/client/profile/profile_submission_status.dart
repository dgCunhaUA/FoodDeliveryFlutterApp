abstract class ProfileSubmissionStatus {
  const ProfileSubmissionStatus();
}

class InitialProfileSubmissionStatus extends ProfileSubmissionStatus {
  const InitialProfileSubmissionStatus();
}

class ProfileUpdateSubmitting extends ProfileSubmissionStatus {}

class ProfileUpdateSubmissionSuccess extends ProfileSubmissionStatus {}

class ProfileUpdateSubmissionFailed extends ProfileSubmissionStatus {
  final Exception exception;

  ProfileUpdateSubmissionFailed(this.exception);
}
