import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.8.197:3000';

  Future<String> getData() async {
    final response = await http.get(Uri.parse('$baseUrl/'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> sendData(dynamic data) async {
    print('Sending data to: $baseUrl/data');
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/data'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'data': data}),
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to send data: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error sending data: $error');
      throw error; // Re-throw for further handling in the UI
    }
  }

  Future<List<Map<String, dynamic>>> fetchItems() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/items'));

      if (response.statusCode == 200) {
        // Decode the JSON response body into a Dart List
        var items = jsonDecode(response.body) as List<dynamic>;
        var dateFormat = DateFormat('yyyy-MM-dd');
        // Extract relevant fields
        List<Map<String, dynamic>> filteredItems = items.map((item) {
          var date = DateTime.parse(item['date']);
          var formattedDate = dateFormat.format(date);

          return {
            'id': item['_id'],
            'task': item['task'],
            'date': formattedDate
          };
        }).toList();

        return filteredItems;
      } else {
        print('Failed to load items: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load items');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load items');
    }
  }
}
