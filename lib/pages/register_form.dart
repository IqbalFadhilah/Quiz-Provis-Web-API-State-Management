import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login_form.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RegistrationForm(),
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

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
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
              Text(
                'Register', // Tambahkan teks 'Register' di atas ikon
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
                    final String apiUrl = 'http://146.190.109.66:8000/users/';
                    final Map<String, dynamic> registerData = {
                      'username': _usernameController.text,
                      'password': _passwordController.text,
                    };

                    final http.Response response = await http.post(
                      Uri.parse(apiUrl),
                      headers: <String, String>{
                        'accept': 'application/json',
                        'Content-Type': 'application/json',
                      },
                      body: jsonEncode(registerData),
                    );

                    print(response.body); // Tambahkan baris ini untuk mencetak respons dari server

                    if (response.statusCode == 200) {
                      // Jika server mengembalikan respons OK, maka registrasi berhasil
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Registration successful!')),
                      );
                      // Navigasi ke halaman beranda setelah registrasi berhasil
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginForm()),
                      );
                    } else {
                      // Jika response tidak OK, tampilkan pesan error
                      var responseData = json.decode(response.body);
                      var errorMessage = responseData['message']; // Ganti 'message' dengan key yang sesuai dari API Anda
                      handlingStatusCode(context, 'Failed to register: $errorMessage');
                    }
                  }
                },
                child: Text('Register'),
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
