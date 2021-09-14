import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:auftrag_mobile/constants/api_constants.dart';
import 'package:auftrag_mobile/models/order.dart';
import 'package:auftrag_mobile/preferences/preferences.dart';
import 'package:auftrag_mobile/models/invoice.dart';

class SearchApiClient {
  static const baseUrl =
      ApiConstants.BASE_URL; //url generated with `valet share command`
  final http.Client httpClient;

  SearchApiClient({http.Client httpClient})
      : httpClient = httpClient ?? http.Client();

  Future<List<Invoice>> searchInvoice(String query) async {
    final url = '$baseUrl/search?type=user&q=$query';

    final token = Prefer.prefs.getString('token');

    final response = await this.httpClient.get(
          Uri.parse(url),
          headers: requestHeaders(token),
        );
    print(response.statusCode);
    if (response.statusCode != 200) {
      throw Exception('Error getting invoices.');
    }

    final invoiceJson = jsonDecode(response.body)['data'] as List;

    return invoiceJson.map((user) => Invoice.fromJson(user)).toList();
  }

  Future<List<Order>> searchOrders(String query) async {
    final url = '$baseUrl/search?type=tweet&q=$query';

    final token = Prefer.prefs.getString('token');

    final response = await this.httpClient.get(
          Uri.parse(url),
          headers: requestHeaders(token),
        );
    print(response.statusCode);
    if (response.statusCode != 200) {
      throw Exception('Error getting Orders.');
    }

    final orderJson = jsonDecode(response.body)['data'] as List;

    return orderJson.map((order) => Order.fromJson(order)).toList();
  }
}
