import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_project/models/Item.dart';
import 'package:flutter_project/utils/api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:localstorage/localstorage.dart';
import 'package:location_platform_interface/location_platform_interface.dart';

import '../models/Order.dart';
import '../models/Rider.dart';
import '../models/Client.dart';

class UserRepository {
  final Dio _dio = Dio();

  final Options options = Options(sendTimeout: 5000, receiveTimeout: 5000);

  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final LocalStorage map_storage = LocalStorage('map');

  Future<String?> getToken() async {
    var value = await storage.read(key: 'token');
    if (value != null) {
      return value;
    }
    return null;
  }

  Future<Client?> getClient() async {
    String? data = await storage.read(key: 'client');
    if (data != null) {
      return Client.fromJson(jsonDecode(data));
    }
    throw Exception();
  }

  Future<Rider?> getRider() async {
    String? data = await storage.read(key: 'rider');
    if (data != null) {
      return Rider.fromJson(jsonDecode(data));
    }
    throw Exception();
  }

  Future<void> _persistClient(Client client) async {
    await storage.write(key: 'client', value: jsonEncode(client));
  }

  Future<void> _persistRider(Rider rider) async {
    await storage.write(key: 'rider', value: jsonEncode(rider));
  }

  Future<void> _deleteStorage() async {
    //storage.delete(key: 'token');
    storage.deleteAll();
    map_storage.clear();
  }

  Future<void> _persistCurrentOrder(Order order) async {
    await storage.write(key: 'order', value: jsonEncode(order));
  }

  Future<Order?> _getCurrentOrder() async {
    String? data = await storage.read(key: 'order');
    if (data != null) {
      return Order.fromJson(jsonDecode(data));
    }

    return null;
  }

  Future<Client> login(
      {required String email, required String password}) async {
    try {
      final response = await _dio.post(
        '$urlAPI/client/login',
        data: {'email': email, 'password': password},
        options: options,
      );

      if (response.statusCode == 200) {
        Client client = Client.fromJson(response.data);

        await _persistClient(client);

        return client;
      }
      throw Exception("Login Error");
    } on DioError catch (e) {
      print(e);
      if (e.response!.statusCode == 400) {
        throw Exception("Password Incorreta");
      }

      throw Exception("Erro ao fazer login");
    }
  }

  Future<Client> signUp(
      {required String email,
      required String password,
      required String username,
      required String address}) async {
    try {
      final response = await _dio.post(
        '$urlAPI/client/register',
        data: {
          'name': username,
          'email': email,
          'password': password,
          'address': address,
        },
        options: options,
      );

      if (response.statusCode == 201) {
        Client user = Client.fromJson(response.data);

        await _persistClient(user);

        return user;
      }
      throw Exception("Erro");
    } on DioError catch (e) {
      if (e.response!.statusCode == 409) {
        throw Exception("Email já utilizado");
      }

      throw Exception("Erro no registo");
    }
  }

  Future<Rider> signUpRider(
      {required String email,
      required String password,
      required String username,
      required String address,
      required String vehicle}) async {
    try {
      final response = await _dio.post(
        '$urlAPI/rider/register',
        data: {
          'name': username,
          'email': email,
          'password': password,
          'address': address,
          'vehicle': vehicle,
        },
        options: options,
      );

      if (response.statusCode == 201) {
        Rider rider = Rider.fromJson(response.data);

        await _persistRider(rider);

        return rider;
      }

      throw Exception("Erro");
    } on DioError catch (e) {
      if (e.response!.statusCode == 409) {
        throw Exception("Email já utilizado");
      }

      throw Exception("Erro no registo");
    }
  }

  Future<Rider> loginRider(
      {required String email, required String password}) async {
    try {
      final response = await _dio.post(
        '$urlAPI/rider/login',
        data: {'email': email, 'password': password},
        options: options,
      );

      if (response.statusCode == 200) {
        Rider rider = Rider.fromJson(response.data);

        await _persistRider(rider);

        return rider;
      }
      throw Exception("Login Error");
    } on DioError catch (e) {
      print(e);
      if (e.response!.statusCode == 400) {
        throw Exception("Password Incorreta");
      }

      throw Exception("Erro ao fazer login");
    }
  }

  Future<void> signOut() async {
    await _deleteStorage();
  }

  Future<File> uploadClientPhoto(File photo) async {
    try {
      Client? client = await getClient();

      String fileName = photo.path.split('/').last;

      FormData formData = FormData.fromMap({
        "id": client!.id,
        "photo": await MultipartFile.fromFile(photo.path, filename: fileName),
        "filename": fileName
      });

      Response response = await _dio.post(
        '$urlAPI/client/upload',
        data: formData,
        options: options,
      );

      if (response.statusCode == 200) {
        Client updatedClient = Client.fromJson(response.data);
        await _persistClient(updatedClient);

        return photo;
      } else {
        throw Exception(response.statusMessage);
      }

      //return response.data['id'];
    } on DioError catch (e) {
      print(e);
      throw Exception("Erro ao fazer upload");
    }
  }

  Future<File> uploadRiderPhoto(File photo) async {
    try {
      Rider? rider = await getRider();

      String fileName = photo.path.split('/').last;

      FormData formData = FormData.fromMap({
        "id": rider!.id,
        "photo": await MultipartFile.fromFile(photo.path, filename: fileName),
        "filename": fileName
      });

      Response response = await _dio.post(
        '$urlAPI/rider/upload',
        data: formData,
        options: options,
      );

      print(response.data);

      if (response.statusCode == 200) {
        Rider updatedRider = Rider.fromJson(response.data);
        await _persistRider(updatedRider);

        return photo;
      } else {
        throw Exception(response.statusMessage);
      }

      //return response.data['id'];
    } on DioError catch (e) {
      print(e);
      throw Exception("Erro ao fazer upload");
    }
  }

  Future<Order> createOrder(
    //List<Item> items,
    String restaurantName,
    String restaurantAddress,
  ) async {
    try {
      Client? client = await getClient();

      final response = await _dio.post(
        '$urlAPI/order/create',
        data: {
          'restaurant_name': restaurantName,
          'restaurant_address': restaurantAddress,
          "client_id": client!.id,
          "client_name": client.name,
          "client_address": client.address
        },
        options: options,
      );

      if (response.statusCode == 201) {
        Order order = Order.fromJson(response.data);

        return order;
      }
      throw Exception("Error");
    } on DioError catch (e) {
      throw Exception("Error");
    }
  }

  Future<List<Order>> fetchOrders() async {
    try {
      Client? client = await getClient();

      final response = await _dio.get(
        '$urlAPI/order/client/${client!.id}/active',
        options: options,
      );

      List<Order> orders = [];
      if (response.statusCode == 200) {
        for (var data in response.data) {
          orders.add(Order.fromJson(data));
        }

        return orders;
      }
      throw Exception("Error");
    } on DioError catch (e) {
      print(e);
      throw Exception("Error");
    }
  }

  Future<List<Order>> fetchRiderOrders() async {
    List<Order> orders = [];

    Order? storedOrder = await _getCurrentOrder();

    if (storedOrder != null) {
      orders.add(storedOrder);
      return orders;
    }

    try {
      Rider? rider = await getRider();

      final response = await _dio.get(
        '$urlAPI/order/rider/${rider!.id}',
        options: options,
      );

      if (response.statusCode == 200) {
        for (var data in response.data) {
          orders.add(Order.fromJson(data));
        }

        return orders;
      }
      throw Exception("Error");
    } on DioError catch (e) {
      //print(e);
      throw Exception("Error");
    }
  }

  Future<Order> acceptOrder(Order order) async {
    try {
      Rider? rider = await getRider();

      final response = await _dio.put(
        '$urlAPI/order/accept',
        data: {
          "order_id": order.id,
          "rider_name": rider!.name,
          "rider_lat": 0.1,
          "rider_lng": 0.1,
          "order_status": "Delivering",
        },
        options: options,
      );

      if (response.statusCode == 201) {
        Order order = Order.fromJson(response.data);

        await _persistCurrentOrder(order);

        return order;
      }
      throw Exception("Error");
    } on DioError catch (e) {
      print(e);
      throw Exception("Error");
    }
  }

  Future<Order> updateRiderCoords(int id, LocationData? currentPosition) async {
    try {
      final response = await _dio.put(
        '$urlAPI/order/rider/update',
        data: {
          'order_id': id,
          'rider_lat': currentPosition!.latitude,
          "rider_lng": currentPosition.longitude
        },
        options: options,
      );

      if (response.statusCode == 200) {
        Order order = Order.fromJson(response.data);

        return order;
      }
      throw Exception("Error");
    } on DioError catch (e) {
      print(e);
      throw Exception("Error");
    }
  }

  Future<Order> getRiderCoords(int id) async {
    try {
      final response = await _dio.get(
        '$urlAPI/order/$id/coords',
        options: options,
      );

      if (response.statusCode == 200) {
        Order order = Order.fromJson(response.data);

        return order;
      }
      throw Exception("Error");
    } on DioError catch (e) {
      print(e);
      throw Exception("Error");
    }
  }
}
