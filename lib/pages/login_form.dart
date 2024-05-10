import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'item.dart'; // Jika Anda memiliki file item.dart untuk menampilkan item, Anda dapat menyertakan file tersebut di sini

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginForm(),
  ));
}

void handlingStatusCode(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 700),
    ),
  );
}

Future<String?> fetchAccessToken(String username, String password) async {
  final apiUrl = 'http://146.190.109.66:8000/login';
  final loginData = {'username': username, 'password': password};

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: <String, String>{
      'accept': 'application/json',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(loginData),
  );

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    return responseData['access_token'];
  } else {
    throw Exception('Failed to fetch access token');
  }
}

Future<void> fetchItems(String accessToken) async {
  final apiUrl = 'http://146.190.109.66:8000/token';

  final response = await http.get(
    Uri.parse(apiUrl),
    headers: <String, String>{
      'accept': 'application/json',
      'Authorization': 'Bearer $accessToken', // Gunakan token akses dalam header Authorization
    },
  );

  if (response.statusCode == 200) {
    // Handle response data
    // Misalnya, Anda ingin mengambil data item setelah mendapatkan token akses tambahan
  } else {
    throw Exception('Failed to fetch items');
  }
}


class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // Variabel untuk menyimpan access token
  String? accessToken;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(100.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Icon(
                Icons.account_circle,
                size: 100.0,
              ),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      final accessToken = await fetchAccessToken(_usernameController.text, _passwordController.text);
                      print('Access token: $accessToken');

                      if (accessToken != null) {
                        // Navigasi ke halaman berikutnya setelah mendapatkan access token
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => ItemListPage(accessToken: accessToken)),
                        );
                      }
                    } catch (e) {
                      handlingStatusCode(context, 'Failed to login: $e');
                    }
                  }
                },
                child: Text('Login'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}