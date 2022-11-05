class Order {
  int? id;
  String? restaurantName;
  String? restaurantAddress;
  int? clientId;
  String? clientName;
  String? clientAddress;
  String? orderStatus;
  String? updatedAt;
  String? createdAt;

  Order(
      {this.id,
      this.restaurantName,
      this.restaurantAddress,
      this.clientId,
      this.clientName,
      this.clientAddress,
      this.orderStatus,
      this.updatedAt,
      this.createdAt});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantName = json['restaurant_name'];
    restaurantAddress = json['restaurant_address'];
    clientId = json['client_id'];
    clientName = json['client_name'];
    clientAddress = json['client_address'];
    orderStatus = json['order_status'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['restaurant_name'] = restaurantName;
    data['restaurant_address'] = restaurantAddress;
    data['client_id'] = clientId;
    data['client_name'] = clientName;
    data['client_address'] = clientAddress;
    data['order_status'] = orderStatus;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    return data;
  }
}
