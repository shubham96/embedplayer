import 'package:aurealembed/Screens/Router/routing_data.dart';
import 'package:flutter/foundation.dart';

extension StringExtensions on String {
  RoutingData get getRoutingData{
    var uriData = Uri.parse(this);
    if (kDebugMode) {
      print("queryParameters: ${uriData.queryParameters} path: ${uriData.path}");
    }
    return RoutingData(route: uriData.path, queryParameters: uriData.queryParameters);
  }
}