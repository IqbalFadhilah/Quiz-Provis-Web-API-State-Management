import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  String? _token;

  User get user => _user!;
  String get token => _token!;

  Future<void> register(String username, String password) async {
    final response = await http.post(
      Uri.parse('http://146.190.109.66:8000/user'), // Ganti dengan URL endpoint USER Anda
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Jika server mengembalikan response OK, maka registrasi berhasil
      _user = User(username: username, password: password);
      notifyListeners();
    } else {
      // Jika response tidak OK, lempar exception
      throw Exception('Failed to register.');
    }
  }

  Future<void> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('http://146.190.109.66:8000/login'), // Ganti dengan URL endpoint LOGIN Anda
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Jika server mengembalikan response OK, parse token
      _token = jsonDecode(response.body)['access_token'];
      _user = User(username: username, password: password);
      notifyListeners();
    } else {
      // Jika response tidak OK, lempar exception
      throw Exception('Failed to login.');
    }
  }
}
