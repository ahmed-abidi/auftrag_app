import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:auftrag_mobile/models/invoice_detail.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

import 'package:auftrag_mobile/constants/api_constants.dart';
import 'package:auftrag_mobile/models/invoice.dart';
import 'package:auftrag_mobile/preferences/preferences.dart';

class InvoiceApiClient {
  static const baseUrl = ApiConstants.BASE_URL;
  final http.Client httpClient;

  InvoiceApiClient({http.Client httpClient})
      : httpClient = httpClient ?? http.Client();

  Future<List<Invoice>> fetchInvoices() async {
    final url = '$baseUrl/invoices';

    final token = Prefer.prefs.getString('token');

    final response = await this.httpClient.get(
          Uri.parse(url),
          headers: requestHeaders(token),
        );
    print(response.statusCode);
    if (response.statusCode != 200) {
      throw Exception('Error getting orders.');
    }
    final jsoninvoice = jsonDecode(response.body)['data'];
    final invoiceJson = jsonDecode(response.body)['data'] as List;
    print(jsoninvoice);

    return invoiceJson.map((invoice) => Invoice.fromJson(invoice)).toList();
  }

  Future<Invoicedetail> showInvoice(int id) async {
    final url = '$baseUrl/invoices/$id';

    final token = Prefer.prefs.getString('token');

    final response = await this.httpClient.get(
          Uri.parse(url),
          headers: requestHeaders(token),
        );
    print(response.statusCode);
    if (response.statusCode != 200) {
      throw Exception('Error getting orders.');
    }
    final invoicedetailJson = jsonDecode(response.body)['data'];
    print(invoicedetailJson);
    Invoicedetail invoice = Invoicedetail.fromJson(invoicedetailJson);
    return invoice;
  }

  Future showInvoicetest(int id) async {
    final url = '$baseUrl/invoices/$id';

    final token = Prefer.prefs.getString('token');

    final response = await this.httpClient.get(
          Uri.parse(url),
          headers: requestHeaders(token),
        );
    print(response.statusCode);
    if (response.statusCode != 200) {
      throw Exception('Error getting orders.');
    }
    final invoicedetailJson = jsonDecode(response.body)['data'];
    print(id);
    print(invoicedetailJson);
    //return Invoicedetail.fromJson(invoicedetailJson);
    return response.statusCode;
  }
}
