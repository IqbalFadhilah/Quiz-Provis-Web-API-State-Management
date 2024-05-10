import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'home_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginForm(),
  ));
}

// Fungsi untuk menangani kode status HTTP dan menampilkan pesan kesalahan yang sesuai
void handlingStatusCode(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 700),
    ),
  );
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

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
                size: 100.0, // Atur ukuran ikon sesuai keinginan Anda
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
                      final String apiUrl = 'http://146.190.109.66:8000/login';
                      final Map<String, dynamic> loginData = {
                        'username': _usernameController.text,
                        'password': _passwordController.text,
                      };

                      final http.Response response = await http.post(
                        Uri.parse(apiUrl),
                        headers: <String, String>{
                          'accept': 'application/json',
                          'Content-Type': 'application/json',
                        },
                        body: jsonEncode(loginData),
                      );

                      if (response.statusCode == 200) {
                        // Jika server mengembalikan response OK, maka login berhasil
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Login successful!')),
                        );
                        // Navigasi ke halaman beranda setelah login berhasil
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      } else {
                        // Jika response tidak OK, tampilkan pesan error
                        var responseData = json.decode(response.body);
                        var errorMessage = responseData['message']; // Ganti 'message' dengan key yang sesuai dari API Anda
                        handlingStatusCode(context, 'Failed to login: $errorMessage');
                      }
                    } catch (e) {
                      handlingStatusCode(context, 'Failed to login.');
                    }
                  }
                },
                child: Text('Login'),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF00AA13)), // Warna hijau Gojek
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
