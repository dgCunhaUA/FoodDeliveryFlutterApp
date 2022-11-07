import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/client/cart/cart_manage_status.dart';
import 'package:flutter_project/models/Item.dart';
import 'package:flutter_project/models/Order.dart';
import 'package:flutter_project/repositories/user_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final UserRepository userRepo;

  CartBloc({required this.userRepo})
      : super(CartState(items: [], restaurant: '', address: '')) {
    on<CartEvent>((event, emit) async {
      if (event is AddItemToCart) {
        _handleAddItemToCart(event, emit);
      } else if (event is RemoveItemFromCart) {
        _handleRemoveItemFromCart(event, emit);
      } else if (event is SubmitCart) {
        await _handleCartSubmit(event, emit);
      }
    });
  }

  void _handleAddItemToCart(AddItemToCart event, Emitter<CartState> emit) {
    if (state.restaurant != '' && state.restaurant != event.restaurant) {
      emit(state.setCartManageStatus(
          cartManageStatus:
              CartAddFailed("Não pode adicionar outro restaurante ao pedido")));
    } else {
      emit(state.addItem(
        item: event.item,
        restaurant: event.restaurant,
        address: event.address,
      ));
    }
  }

  void _handleRemoveItemFromCart(
      RemoveItemFromCart event, Emitter<CartState> emit) {
    emit(state.removeItem(item: event.item, restaurant: event.restaurant));
  }

  Future<void> _handleCartSubmit(
      SubmitCart event, Emitter<CartState> emit) async {
    emit(state.setCartManageStatus(cartManageStatus: CartSubmitting()));

    try {
      await userRepo.createOrder(state.restaurant, state.address);

      emit(state.setCartManageStatus(cartManageStatus: CartSubmitSuccess()));

      emit(state.reset());
    } on Exception catch (e) {
      emit(state.setCartManageStatus(cartManageStatus: CartSubmitFailed()));
    }
  }
}
