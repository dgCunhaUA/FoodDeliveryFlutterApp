part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class AddItemToCart extends CartEvent {
  final String item;

  AddItemToCart({required this.item});
}
