part of 'orders_bloc.dart';

@immutable
abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersLoadedSuccess extends OrdersState {
  final List<Order> orders;

  OrdersLoadedSuccess(this.orders);
}

class OrdersLoadedFailed extends OrdersState {
  final String error;

  OrdersLoadedFailed(this.error);
}
