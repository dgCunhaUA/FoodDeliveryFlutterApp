part of 'orders_bloc.dart';

@immutable
abstract class RiderOrdersEvent {}

class FectingOrders extends RiderOrdersEvent {}

class AcceptOrder extends RiderOrdersEvent {
  final Order order;

  AcceptOrder(this.order);
}
