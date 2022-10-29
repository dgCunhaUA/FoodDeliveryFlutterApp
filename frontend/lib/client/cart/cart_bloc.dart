import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/client/cart/cart_manage_status.dart';
import 'package:flutter_project/models/Item.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState(items: [])) {
    on<CartEvent>((event, emit) {
      print("Event: ");
      print(event);
      if (event is AddItemToCart) {
        _handleAddItemToCart(event, emit);
      } else if (event is RemoveItemFromCart) {
        _handleRemoveItemFromCart(event, emit);
      }
    });
  }

  void _handleAddItemToCart(AddItemToCart event, Emitter<CartState> emit) {
    emit(state.addItem(item: event.item));
  }

  void _handleRemoveItemFromCart(
      RemoveItemFromCart event, Emitter<CartState> emit) {
    emit(state.removeItem(item: event.item));
  }
}
