import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
}

class Fetch extends StatefulWidget {
  const Fetch({super.key});

  @override
  State<Fetch> createState() => _FetchState();
}

class _FetchState extends State<Fetch> {
  @override

    Future<void> fetchItems() async {
    final response = await http.get(Uri.parse('http://localhost:3000/items'));

    if (response.statusCode == 200) {
      setState(() {
        var items = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load items');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  }
