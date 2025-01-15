import 'dart:io';

import 'package:flutter_pusher_client/flutter_pusher.dart';

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

FlutterPusher getPusherClient(String token) {
  PusherOptions options = PusherOptions(
      encrypted: false,
      host: '10.0.3.2',
      cluster: 'ap1',
      port: 6001,
      auth: PusherAuth('http://10.0.3.2:8000/api/broadcasting/auth',
          headers: {'Authorization': 'Bearer $token'}));
  return FlutterPusher('d71e6cbc448a4eccfeb2', options, enableLogging: true);
}

void onConnectionStateChange(ConnectionStateChange event) {
  print(event.currentState);
  if (event.currentState == 'CONNECTED') {
    print('connected');
  } else if (event.currentState == 'DISCONNECTED') {
    print('disconnected');
  }
}
