part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class AddItemToCart extends CartEvent {
  final Item item;
  final String restaurant;

  AddItemToCart({required this.item, required this.restaurant});
}

class RemoveItemFromCart extends CartEvent {
  final Item item;
  final String restaurant;

  RemoveItemFromCart({required this.item, required this.restaurant});
}
