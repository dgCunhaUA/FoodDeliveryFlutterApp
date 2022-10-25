import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/rider/profile/rider_profile_event.dart';
import 'package:flutter_project/rider/profile/rider_profile_state.dart';

import '../../models/Rider.dart';

class RiderProfileBloc extends Bloc<RiderProfileEvent, RiderProfileState> {
  RiderProfileBloc({required Rider rider})
      : super(RiderProfileState(rider: rider));
}
