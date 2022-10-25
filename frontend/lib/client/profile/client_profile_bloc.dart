import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/client/profile/client_profile_event.dart';
import 'package:flutter_project/client/profile/client_profile_state.dart';

import '../../models/Client.dart';

class ClientProfileBloc extends Bloc<ClientProfileEvent, ClientProfileState> {
  ClientProfileBloc({required Client client})
      : super(ClientProfileState(client: client));
}
