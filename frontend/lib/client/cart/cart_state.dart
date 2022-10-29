part of 'cart_bloc.dart';

enum CartStatus { empty, notEmpty }

class CartState {
  final List<Item> items;
  CartManageStatus cartManageStatus;
  CartStatus cartStatus;

  CartState({
    required this.items,
    this.cartManageStatus = const CartInitialStatus(),
    this.cartStatus = CartStatus.empty,
  });

  CartState addItem({
    Item? item,
  }) {
    if (item != null) {
      items.add(item);

      if (items.contains(item)) {
        cartManageStatus = CartAddSuccess();
      } else {
        cartManageStatus = CartAddFailed();
      }
    } else {
      cartManageStatus = CartAddFailed();
    }

    if (items.isEmpty) {
      cartStatus = CartStatus.empty;
    } else {
      cartStatus = CartStatus.notEmpty;
    }

    return CartState(
      items: items,
      cartManageStatus: cartManageStatus,
      cartStatus: cartStatus,
    );
  }

  CartState removeItem({
    Item? item,
  }) {
    if (items.remove(item)) {
      cartManageStatus = CartRemoveSuccess();
    } else {
      cartManageStatus = CartRemoveFailed();
    }

    if (items.isEmpty) {
      cartStatus = CartStatus.empty;
    } else {
      cartStatus = CartStatus.notEmpty;
    }

    return CartState(
      items: items,
      cartManageStatus: cartManageStatus,
      cartStatus: cartStatus,
    );
  }
}
