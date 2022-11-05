part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class AddItemToCart extends CartEvent {
  final Item item;
  final String restaurant;
  final String address;

  AddItemToCart({
    required this.item,
    required this.restaurant,
    required this.address,
  });
}

class RemoveItemFromCart extends CartEvent {
  final Item item;
  final String restaurant;
  final String address;

  RemoveItemFromCart({
    required this.item,
    required this.restaurant,
    required this.address,
  });
}

class SubmitCart extends CartEvent {}
