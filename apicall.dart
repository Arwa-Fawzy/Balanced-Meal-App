// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> apicall(List<String> items) async {
  const url = 'https://uz8if7.buildship.run/placeOrder';

  // Convert List<String> to List<Map<String, dynamic>>
  final parsedItems = items.map((item) => jsonDecode(item)).toList();

  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({"items": parsedItems}),
  );

  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    return result == true;
  } else {
    return false;
  }
}
