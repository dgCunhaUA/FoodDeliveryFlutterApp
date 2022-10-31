abstract class CartManageStatus {
  const CartManageStatus();
}

class CartInitialStatus extends CartManageStatus {
  const CartInitialStatus();
}

class CartAddSuccess extends CartManageStatus {}

class CartAddFailed extends CartManageStatus {
  String message;

  CartAddFailed(this.message);
}

class CartRemoveSuccess extends CartManageStatus {}

class CartRemoveFailed extends CartManageStatus {}
