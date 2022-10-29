abstract class CartManageStatus {
  const CartManageStatus();
}

class CartInitialStatus extends CartManageStatus {
  const CartInitialStatus();
}

class CartAddSuccess extends CartManageStatus {}

class CartAddFailed extends CartManageStatus {}

class CartRemoveSuccess extends CartManageStatus {}

class CartRemoveFailed extends CartManageStatus {}
