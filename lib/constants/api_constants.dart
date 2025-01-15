import 'dart:io';

class ApiConstants {
  static const BASE_URL = 'https://order-crm.de/api';
  //static const BASE_URL = 'http://c516354e4fc3.ngrok.io/api';
}

Map<String, String> requestHeaders(String token) {
  return {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  };
}
