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
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 100, // Atur posisi atas gambar sesuai keinginan Anda
              left: screenWidth / 2 - 100, // Posisi tengah layar
              child: Container(
                width: 200.0, // Lebar gambar
                height: 200.0, // Tinggi gambar
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'),
                  ),
                ),
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
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF00AA13)),
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
      ),
    );
  }
}
