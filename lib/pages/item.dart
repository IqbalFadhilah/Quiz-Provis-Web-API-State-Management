import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Item {
  final int id;
  final String title;
  final String description;
  final double price;
  final String img_name;

  Item({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.img_name,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      img_name: json['img_name'],
    );
  }
}

class ItemListPage extends StatefulWidget {
  @override
  _ItemListPageState createState() => _ItemListPageState();

  final String? accessToken; // Tambahkan accessToken sebagai field

  const ItemListPage({Key? key, required this.accessToken}) : super(key: key);
}

class _ItemListPageState extends State<ItemListPage> {
  late Future<List<Item>> _futureItems;

  @override
  void initState() {
    super.initState();
    _futureItems = fetchItems(widget.accessToken!);
  }

  Future<List<Item>> fetchItems(String accessToken) async {
    try {
      final response = await http.get(
        Uri.parse('http://146.190.109.66:8000/items/'),
        headers: <String, String>{
          'accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => Item.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load items: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching items: $e');
      throw Exception('Failed to load items');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item List'),
      ),
      body: FutureBuilder<List<Item>>(
        future: _futureItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                return ListTile(
                  title: Text(item.title),
                  subtitle: Text(item.description),
                  trailing: Text('\Rp${item.price.toStringAsFixed(2)}'),
                  leading: Image.network(item.img_name),
                );
              },
            );
          }
        },
      ),
    );
  }
}


