
import 'dart:convert';

import 'package:app_faculdade/config/app_settings.dart';

class ServiceParameters {
  final String _host = '192.168.20.106';
  final String _port = '8080';
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  String getUrl() {
    return 'http://$_host:$_port';
  }
}