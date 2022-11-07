class Order {
  late int id;
  late String restaurantName;
  late String restaurantAddress;
  late int clientId;
  late String clientName;
  late String clientAddress;
  late String orderStatus;
  late String updatedAt;
  late String createdAt;

  String? riderName;
  double? riderLat;
  double? riderLng;

  Order({
    required this.id,
    required this.restaurantName,
    required this.restaurantAddress,
    required this.clientId,
    required this.clientName,
    required this.clientAddress,
    required this.orderStatus,
    required this.updatedAt,
    required this.createdAt,
    this.riderName,
    this.riderLat,
    this.riderLng,
  });

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

    riderName = json['rider_name'];
    if (json["rider_lat"] is String) {
      riderLat = double.parse(json['rider_lat']);
      riderLng = double.parse(json['rider_lng']);
    } else if (json["rider_lat"] is int) {
      riderLat = json['rider_lat'].toDouble();
      riderLng = json['rider_lng'].toDouble();
    } else {
      riderLat = json['rider_lat'];
      riderLng = json['rider_lng'];
    }
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

    data['rider_name'] = riderName;
    data['rider_lat'] = riderLat;
    data['rider_lng'] = riderLng;
    return data;
  }
}
