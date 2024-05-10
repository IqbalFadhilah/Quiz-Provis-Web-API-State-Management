import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LandingPage(),
  ));
}

class LandingPage extends StatelessWidget {
  const LandingPage({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context){
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: screenHeight / 1.5, // Atur tinggi Container sesuai keinginan Anda
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/logo.png'), // Ganti dengan path logo Anda
                fit: BoxFit.cover, // Anda bisa mengubah ini sesuai kebutuhan
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFC0F3FF), Colors.white]),
            ),
          ),
          Positioned(
            top: screenHeight / 2,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.all(20.0), // Atur padding sesuai keinginan Anda
              child: Column(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                     
                    },
                    child: Text(
                      'Login',
                    ),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      minimumSize: MaterialStateProperty.all<Size>(Size(screenWidth * 0.5, 50))
                    ),
                  ),
                  SizedBox(height: 20), // Jarak antara tombol login dan daftar
                  ElevatedButton(
                    onPressed: () {
                      
                    },
                    child: Text(
                      'Daftar',
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      minimumSize: MaterialStateProperty.all<Size>(Size(screenWidth * 0.5, 50))
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}