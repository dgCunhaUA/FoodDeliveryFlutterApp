import 'package:flutter_project/auth/form_submission_status.dart';
import 'package:flutter_project/models/Rider.dart';

import '../../models/Client.dart';
import '../../models/User.dart';

class ClientProfileState {
  final Client client;

  ClientProfileState({required this.client});

  ClientProfileState copyWith({required Client client}) {
    return ClientProfileState(
      client: client,
    );
  }
}
