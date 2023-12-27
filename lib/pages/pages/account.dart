import 'package:flutter/material.dart';
import '../constants.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  List categories = [];
  final WooCommerceAPIHandler apiHandler = WooCommerceAPIHandler();

  @override
  void initState() {
    super.initState();
    getcategories();
  }

  Future<void> getcategories() async {
    try {
      var products =
          await apiHandler.wooCommerceAPI.getAsync("products/categories");
      setState(() {
        categories = products;
      });
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Daily'),
          backgroundColor: Color(0xFF6a9739),
        ),
        body: ListView(
          children: [
            Card(
              child: Column(
                children: [
                  ListTile(
                    title: Text('Card Title'),
                    subtitle: Text('Subtitle for Card'),
                  ),
                  Divider(),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 3, // Number of lists
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('List ${index + 1} Item 1'),
                        onTap: () {
                          // Action for each list item
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            // Add more cards with lists here
          ],
        ),
      ),
    );
  }
}
