part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class AddItemToCart extends CartEvent {
  final Item item;

  AddItemToCart({required this.item});
}

class RemoveItemFromCart extends CartEvent {
  final Item item;

  RemoveItemFromCart({required this.item});
}
