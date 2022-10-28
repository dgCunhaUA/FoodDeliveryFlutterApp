import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState()) {
    on<CartEvent>((event, emit) {
      print("Event: ");
      print(event);
      if (event is AddItemToCart) {
        _handleAddItemToCart(event, emit);
      }
    });
  }

  void _handleAddItemToCart(AddItemToCart event, Emitter<CartState> emit) {
    emit(state.copyWith(item: event.item, cartStatus: CartStatus.notEmpty));
  }
}
