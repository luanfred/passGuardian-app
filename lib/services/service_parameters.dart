
import 'dart:convert';

import 'package:app_faculdade/config/app_settings.dart';

class ServiceParameters {
  final String _host = '18.208.157.120:8080';
  final String _port = '8080';
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': '*/*',
  };

  String getUrl() {
    return 'http://$_host';
  }
}