// import 'package:flutter/material.dart';
// import 'package:quiz_flutter_web_api/pages/chart.dart';
// import 'dart:async';
// import 'package:quiz_flutter_web_api/pages/home_screen.dart';
// import 'package:quiz_flutter_web_api/pages/chart.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Status Pesanan',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: StatusPage(),
//     );
//   }
// }

// class StatusPage extends StatefulWidget {
//   @override
//   _StatusPageState createState() => _StatusPageState();
// }

// class _StatusPageState extends State<StatusPage> {
//   int _status = 0; // 0: Menunggu Konfirmasi, 1: Pesanan diterima, 2: Sedang diantar, 3: Pesanan Sampai
//   IconData _icon = Icons.timer; // Icon default
//   Color _iconColor = Colors.green; // Warna default untuk ikon
//   int _currentIndex = 2; // Index untuk BottomNavigationBar

//   @override
//   void initState() {
//     super.initState();
//     // Mulai timer untuk mengubah status setiap 5 detik
//     Timer.periodic(Duration(seconds: 5), (timer) {
//       setState(() {
//         if (_status < 3) {
//           _status++;
//           _updateIcon();
//         } else {
//           timer.cancel(); // Hentikan timer setelah status mencapai yang terakhir
//         }
//       });
//     });
//   }

//   // Metode untuk memperbarui ikon sesuai status
//   void _updateIcon() {
//     switch (_status) {
//       case 0:
//         _icon = Icons.access_time;
//         _iconColor = Colors.green; // Warna hijau untuk menunggu konfirmasi
//         break;
//       case 1:
//         _icon = Icons.restaurant;
//         _iconColor = Colors.green; // Warna hijau untuk pesanan diterima
//         break;
//       case 2:
//         _icon = Icons.motorcycle;
//         _iconColor = Colors.green; // Warna putih untuk pesanan sedang diantar
//         break;
//       case 3:
//         _icon = Icons.check;
//         _iconColor = Colors.green; // Warna putih untuk pesanan sudah sampai
//         break;
//       default:
//         _icon = Icons.timer;
//         _iconColor = Colors.green; // Warna hijau default
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Status Pesanan'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Icon(_icon, size: 100.0, color: _iconColor), // Menampilkan ikon sesuai status dengan warna yang sesuai
//             SizedBox(height: 20.0),
//             Text(
//               _getStatusText(), // Menampilkan teks status
//               style: TextStyle(fontSize: 20.0),
//             ),
//             SizedBox(height: 20.0),
//             if (_status == 3) // Tombol konfirmasi pesanan muncul hanya saat status terakhir
//               ElevatedButton(
//   onPressed: () {
//     // Aksi ketika tombol diklik
//     print('Konfirmasi Pesanan');
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (BuildContext context) => CartScreen(cartItems: []),
//       ),
//     );
//   },
//   style: ButtonStyle(
//     backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Warna hijau untuk tombol
//   ),
//   child: Text(
//     'Konfirmasi Pesanan',
//     style: TextStyle(color: Colors.white), // Warna putih untuk teks tombol
//   ),
// ),

//           ],
//         ),
//       ),
//       bottomNavigationBar: CustomBottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (int index) {
//           // Handle navigation here
//           if (index == 0) {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (BuildContext context) => HomeScreen(),
//               ),
//             );
//           } else if (index == 1) {
//              Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (BuildContext context) => CartScreen(cartItems: []),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }

//   // Metode untuk mendapatkan teks status
//   String _getStatusText() {
//     switch (_status) {
//       case 0:
//         return 'Menunggu Pesanan Dikonfirmasi';
//       case 1:
//         return 'Pesanan sudah diterima oleh restoran';
//       case 2:
//         return 'Pesanan sedang diantar';
//       case 3:
//         return 'Pesanan sudah sampai';
//       default:
//         return 'Status Tidak Diketahui';
//     }
//   }
// }

// class CustomBottomNavigationBar extends StatelessWidget {
//   final int currentIndex;
//   final Function(int) onTap;

//   const CustomBottomNavigationBar({required this.currentIndex, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: currentIndex,
//       onTap: onTap,
//       items: const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.shopping_cart),
//           label: 'Keranjang',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.assignment),
//           label: 'Status', // Change label to 'Status'
//         ),
//       ],
//     );
//   }
// }
