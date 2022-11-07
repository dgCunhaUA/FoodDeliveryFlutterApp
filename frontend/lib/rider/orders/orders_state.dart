part of 'orders_bloc.dart';

@immutable
abstract class RiderOrdersState {}

class OrdersInitial extends RiderOrdersState {}

class OrdersLoading extends RiderOrdersState {}

class OrdersLoadedSuccess extends RiderOrdersState {
  final List<Order> orders;

  OrdersLoadedSuccess(this.orders);
}

class OrdersLoadedFailed extends RiderOrdersState {
  final String error;

  OrdersLoadedFailed(this.error);
}
