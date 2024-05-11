import 'package:flutter/material.dart';
import '../model/CartItem.dart';
import 'cart.dart';
import 'item.dart';

class CartPage extends StatefulWidget {
  final int userId;

  const CartPage({Key? key, required this.userId}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<List<CartItem>> _futureCartItems;

  @override
  void initState() {
    super.initState();
    _futureCartItems = CartService().fetchUserCart(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang Saya'),
      ),
      body: FutureBuilder<List<CartItem>>(
        future: _futureCartItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<CartItem> cartItems = snapshot.data!;
            return ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartItems[index];
                return ListTile(
                  title: Text('Item ID: ${cartItem.itemId}'),
                  subtitle: Text('Quantity: ${cartItem.quantity}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            cartItem.quantity--;
                            _updateCartItem(cartItem);
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            cartItem.quantity++;
                            _updateCartItem(cartItem);
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<void> _updateCartItem(CartItem cartItem) async {
    try {
      await CartService().addToCart(
        cartItem.itemId,
        cartItem.userId,
        cartItem.quantity,
      );
    } catch (e) {
      print('Error updating cart item: $e');
    }
  }
}


