import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

import 'package:auftrag_mobile/constants/api_constants.dart';
import 'package:auftrag_mobile/models/orderdetail.dart';
import 'package:auftrag_mobile/models/order.dart';
import 'package:auftrag_mobile/models/order_paginator.dart';
import 'package:auftrag_mobile/preferences/preferences.dart';

class OrderApiClient {
  static const baseUrl = ApiConstants.BASE_URL;
  final http.Client httpClient;

  OrderApiClient({http.Client httpClient})
      : httpClient = httpClient ?? http.Client();

  Future<OrderPaginator> fetchOrders(int pageNumber) async {
    final url =
        '$baseUrl/orders/filter/all?page=$pageNumber&page[number]=$pageNumber';

    final token = Prefer.prefs.getString('token');

    final response = await this.httpClient.get(
          Uri.parse(url),
          headers: requestHeaders(token),
        );
    print(response.statusCode);
    if (response.statusCode != 200) {
      throw Exception('Error getting orders.');
    }

    final ordersJson = jsonDecode(response.body)['data'];
    print(ordersJson);
    //final OrderPaginator testjson = OrderPaginator.fromJson(ordersJson);
    //print(testjson);

    return OrderPaginator.fromJson(ordersJson);
  }

  /*Future<OrderPaginator> fetchUserOrders(
      String username, int pageNumber) async {
    final url =
        '$baseUrl/profiles/$username/order?page=$pageNumber&page[number]=$pageNumber';

    final token = Prefer.prefs.getString('token');

    final response = await this.httpClient.get(
          Uri.parse(url),
          headers: requestHeaders(token),
        );
    print(response.statusCode);
    if (response.statusCode != 200) {
      throw Exception('Error getting orders.');
    }

    print(token);

    final ordersJson = jsonDecode(response.body)['data'];

    return OrderPaginator.fromJson(ordersJson);
  }*/

  Future accept(int id) async {
    final url = '$baseUrl/orders/accept/$id';

    final token = Prefer.prefs.getString('token');

    final response = await this.httpClient.get(
          Uri.parse(url),
          headers: requestHeaders(token),
        );
    print(response.statusCode);
    if (response.statusCode != 201) {
      throw Exception('Error following user.');
    }
    print(response.statusCode);
    return response.statusCode;
  }

  Future reject(int id) async {
    final url = '$baseUrl/orders/reject/$id';

    final token = Prefer.prefs.getString('token');

    final response = await this.httpClient.get(
          Uri.parse(url),
          headers: requestHeaders(token),
        );
    print(response.statusCode);
    if (response.statusCode != 201) {
      throw Exception('Error following user.');
    }
    return response.statusCode;
  }

  Future<Order> cancled(int id, String reason) async {
    final url = '$baseUrl/orders/cancel/$id';

    final token = Prefer.prefs.getString('token');

    final response = await this.httpClient.patch(Uri.parse(url),
        headers: requestHeaders(token),
        body: jsonEncode(
          <String, String>{
            'reason': reason,
          },
        ));
    print(response.statusCode);
    if (response.statusCode != 200) {
      throw Exception('Error following user.');
    }
  }

  Future confirm(int id, String date, String time) async {
    final url = '$baseUrl/orders/confirm/$id&';

    final token = Prefer.prefs.getString('token');

    final response = await this.httpClient.patch(Uri.parse(url),
        headers: requestHeaders(token),
        body: jsonEncode(
          <String, String>{
            'start_date': date,
            'start_time': time,
          },
        ));
    print(response.statusCode);
    if (response.statusCode != 200) {
      throw Exception('Error following user.');
    }

    return response.statusCode;
  }

  Future finish(int id, String method, String date, double netTotalprice,
      double totalmatrial) async {
    final url = '$baseUrl/orders/finish/$id';

    final token = Prefer.prefs.getString('token');

    final response = await this.httpClient.patch(Uri.parse(url),
        headers: requestHeaders(token),
        body: jsonEncode(
          <String, String>{
            'method': method,
            'date': date,
            'nettotal': netTotalprice.toString(),
            'totalmatriel': totalmatrial.toString(),
          },
        ));
    print(response.body);
    if (response.statusCode != 200) {
      throw Exception('Error following user.');
    }
    return response.statusCode;
  }

  Future<Order> showOrder(int id) async {
    final url = '$baseUrl/orders/detail/$id';

    final token = Prefer.prefs.getString('token');

    final response = await this.httpClient.get(
          Uri.parse(url),
          headers: requestHeaders(token),
        );
    print(response.statusCode);
    if (response.statusCode != 200) {
      throw Exception('Error getting orders.');
    }
    final orderJson = jsonDecode(response.body)['data'];
    print(orderJson);
    return new Order.fromJson(orderJson);
  }
}
