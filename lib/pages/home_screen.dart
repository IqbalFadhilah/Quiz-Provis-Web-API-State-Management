import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quiz_flutter_web_api/model/food.dart';
import 'package:quiz_flutter_web_api/model/CartItem.dart';
import 'package:quiz_flutter_web_api/pages/statusOrder.dart';
import 'package:quiz_flutter_web_api/widget/foodWidget.dart';
import 'package:quiz_flutter_web_api/pages/chart.dart';

import '../provider/item_read.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  late Timer _timer;
  List<CartItem> cartItems = [];
  List<FoodItem> foodItems = [];

  @override
  void initState() {
    super.initState();
    _startTimer();
    _fetchFoodItems(); // Panggil fungsi untuk mengambil data makanan
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentIndex < 2) {
        _pageController.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.jumpToPage(0);
      }
    });
  }

<<<<<<< HEAD
  void _addToCart(FoodItem item) {
    setState(() {
      var existingItem = cartItems.firstWhere(
        (element) => element.name == item.title,
        orElse: () => CartItem(
          name: item.title,
          imageUrl: item.imgName,
          price: item.price.toDouble(),
          quantity: 0,
        ),
      );

      if (existingItem.quantity == 0) {
        cartItems.add(existingItem);
      }
      existingItem.quantity++;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.title} berhasil ditambahkan ke keranjang!'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Fungsi untuk memanggil API dan mengambil data makanan
  void _fetchFoodItems() async {
    try {
      // Panggil fungsi untuk mengambil data makanan dari API
      List<FoodItem> items = await fetchFoodItemsFromAPI();
      setState(() {
        foodItems = items; // Setel state foodItems dengan data yang diterima dari API
      });
    } catch (error) {
      print('Error fetching food items: $error');
    }
  }
=======
void _addToCart(FoodItem item) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('${item.title} berhasil ditambahkan ke keranjang!'),
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    ),
  );

  var existingItemIndex = cartItems.indexWhere((element) => element.name == item.title);

  if (existingItemIndex != -1) {
    setState(() {
      cartItems[existingItemIndex].quantity++;
    });
  } else {
    setState(() {
      cartItems.add(CartItem(
        name: item.title,
        imageUrl: item.imgName,
        price: item.price.toDouble(),
        quantity: 1,
      ));
    });
  }

  // Kembali ke halaman CartScreen untuk memperbarui UI
  Navigator.popAndPushNamed(context, '/cart');
}
>>>>>>> ab3335cb4bbff50f488dd82dfaf0c1016d92e768





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            // Tambahkan fungsi pencarian di sini
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Tambahkan fungsi notifikasi di sini
            },
          ),
        ],
        centerTitle: false,
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Cari Makanan',
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 16.0),
            hintStyle: TextStyle(color: Colors.black),
          ),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: [
                PromoCard(imageUrl: 'assets/images/promo1.jpg'),
                PromoCard(imageUrl: 'assets/images/promo2.jpg'),
                PromoCard(imageUrl: 'assets/images/promo3.jpg'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'List Makanan Tersedia',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: foodItems.length,
              itemBuilder: (context, index) {
                return FoodItemWidget(
                  foodItem: foodItems[index],
                  onAddToCart: _addToCart, // Pass the function here
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Keranjang',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Profil',
          ),
        ],
        onTap: (int index) {
          // Handle navigation here
          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => CartScreen(cartItems: cartItems),
              ),
            );
          } else if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => HomeScreen(),
              ),
            );
          }
          else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => StatusPage(),
              ),
            );
          }
        },
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomBottomNavigationBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Keranjang',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
    );
  }
}

class PromoCard extends StatelessWidget {
  final String imageUrl;

  PromoCard({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
