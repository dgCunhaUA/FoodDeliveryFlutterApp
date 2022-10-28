part of 'cart_bloc.dart';

enum CartStatus { empty, notEmpty, processing }

class CartState {
  List<String?> items = [];
  CartStatus cartStatus;

  CartState({
    this.cartStatus = CartStatus.empty,
  });

  CartState copyWith({
    String? item,
    CartStatus? cartStatus,
  }) {
    print(item);
    print(cartStatus);
    if (item != null) items.add(item);

    print(items);
    return CartState(
      cartStatus: cartStatus ?? this.cartStatus,
    );
  }
}
