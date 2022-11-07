part of 'cart_bloc.dart';

enum CartStatus { empty, notEmpty }

class CartState {
  List<Item> items;
  String restaurant;
  String address;
  CartManageStatus cartManageStatus;
  CartStatus cartStatus;

  CartState({
    required this.items,
    required this.restaurant,
    required this.address,
    this.cartManageStatus = const CartInitialStatus(),
    this.cartStatus = CartStatus.empty,
  });

  CartState setCartManageStatus({required CartManageStatus cartManageStatus}) {
    return CartState(
      restaurant: restaurant,
      address: address,
      items: items,
      cartManageStatus: cartManageStatus,
      cartStatus: cartStatus,
    );
  }

  CartState addItem({
    required Item item,
    required String restaurant,
    required String address,
  }) {
    items.add(item);

    if (items.contains(item)) {
      cartManageStatus = CartAddSuccess();
    } else {
      cartManageStatus = CartAddFailed('Erro ao adicionar');
    }

    if (items.isEmpty) {
      cartStatus = CartStatus.empty;
    } else {
      cartStatus = CartStatus.notEmpty;
    }

    return CartState(
      restaurant: restaurant,
      address: address,
      items: items,
      cartManageStatus: cartManageStatus,
      cartStatus: cartStatus,
    );
  }

  CartState removeItem({
    required Item item,
    required String restaurant,
  }) {
    if (items.remove(item)) {
      cartManageStatus = CartRemoveSuccess();
    } else {
      cartManageStatus = CartRemoveFailed();
    }

    if (items.isEmpty) {
      cartStatus = CartStatus.empty;
      restaurant = "";
    } else {
      cartStatus = CartStatus.notEmpty;
    }

    return CartState(
      restaurant: restaurant,
      address: address,
      items: items,
      cartManageStatus: cartManageStatus,
      cartStatus: cartStatus,
    );
  }

  CartState reset() {
    return CartState(
        items: [],
        restaurant: '',
        address: '',
        cartManageStatus: const CartInitialStatus(),
        cartStatus: CartStatus.empty);
  }
}
