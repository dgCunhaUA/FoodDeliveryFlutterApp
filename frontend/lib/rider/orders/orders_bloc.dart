import 'package:bloc/bloc.dart';
import 'package:flutter_project/models/Order.dart';
import 'package:flutter_project/repositories/user_repository.dart';
import 'package:meta/meta.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class RiderOrdersBloc extends Bloc<RiderOrdersEvent, RiderOrdersState> {
  final UserRepository userRepo;

  RiderOrdersBloc({required this.userRepo}) : super(OrdersInitial()) {
    on<RiderOrdersEvent>((event, emit) async {
      if (event is FectingOrders) {
        await _handleOrdersFetch(event, emit);
      } else if (event is AcceptOrder) {
        await _handleOrderAccept(event, emit);
      }
    });
  }

  Future<void> _handleOrdersFetch(
      FectingOrders event, Emitter<RiderOrdersState> emit) async {
    emit(OrdersLoading());

    try {
      List<Order> orders = await userRepo.fetchRiderOrders();
      emit(OrdersLoadedSuccess(orders));
    } on Exception catch (e) {
      emit(OrdersLoadedFailed(e.toString()));
    }
  }

  Future<void> _handleOrderAccept(
      AcceptOrder event, Emitter<RiderOrdersState> emit) async {
    emit(OrdersLoading());

    try {
      Order order = await userRepo.acceptOrder(event.order);

      //emit(OrdersLoadedSuccess(order));
    } on Exception catch (e) {
      emit(OrdersLoadedFailed(e.toString()));
    }
  }
}
