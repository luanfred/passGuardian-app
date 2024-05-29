
import 'dart:convert';

import 'package:app_faculdade/config/app_settings.dart';

class ServiceParameters {
  final String _host = 'homologacao-luan.6xymog.easypanel.host';
  final String _port = '8080';
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': '*/*',
  };

  String getUrl() {
    return 'https://$_host';
  }
}