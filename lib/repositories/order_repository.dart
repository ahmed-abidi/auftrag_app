import 'dart:io';

import 'package:auftrag_mobile/blocs/blocs.dart';
import 'package:auftrag_mobile/models/order_paginator.dart';
import 'package:auftrag_mobile/models/orderdetail.dart';

import 'package:auftrag_mobile/services/order_api_client.dart';

class OrderRepository {
  final OrderApiClient orderApiClient;

  OrderRepository({OrderApiClient orderApiClient})
      : orderApiClient = orderApiClient ?? OrderApiClient();

  Future<OrderPaginator> getOrders(int pageNumber) async {
    return orderApiClient.fetchOrders(pageNumber);
  }

  /*Future<OrderPaginator> getUserOrders(
      {String username, int pageNumber}) async {
    return orderApiClient.fetchUserOrders(username, pageNumber);
  }*/

  Future getOrderdetail(int id) async {
    return orderApiClient.showOrder(id);
  }
}
