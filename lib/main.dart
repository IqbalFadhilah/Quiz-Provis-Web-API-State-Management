/* ANGGOTA KELOMPOK
1. MUHAMMAD IQBAL FADHILAH (2202292)
2. NAUFAL NABIL ANUGRAH (2201090)
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_flutter_web_api/pages/landing_page.dart';
import 'package:quiz_flutter_web_api/provider/auth_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(), // Ini membuat instance AuthProvider dan menyediakannya ke seluruh aplikasi
      child: MainApp(), 
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingPage()  
    );
  }
}
