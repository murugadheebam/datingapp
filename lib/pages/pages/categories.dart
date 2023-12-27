import 'package:flutter/material.dart';
import '../constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Categories extends StatefulWidget {
  @override
  CategoriesState createState() => CategoriesState();
}

class CategoriesState extends State<Categories> {
  List categories = [];
  List subcategories = [];

  int selectedIndex = 0; // Initialize with -1 (no category selected)

  final WooCommerceAPIHandler apiHandler = WooCommerceAPIHandler();

  @override
  void initState() {
    super.initState();
    getcategories();
  }

  Future<void> getcategories() async {
    try {
      var products = await apiHandler.wooCommerceAPI
          .getAsync("products/categories?parent_exclude=0");
      categories = products
          .where((category) => category['name'] != 'Uncategorized')
          .toList();

      setState(() {
        categories = categories;
      });
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  void handleCategoryTap(int index, int category_id) async {
    setState(() {
      selectedIndex = index; // Update the selected index
    });
    final String baseUrl = 'http://143.1.1.253/ecommerce/wp-json/custom/v1';
    final String consumerKey = 'YOUR_CONSUMER_KEY';
    final String consumerSecret = 'YOUR_CONSUMER_SECRET';

    final String endpoint = '/my_custom_endpoint/';

    final String url = '$baseUrl$endpoint';

    try {
      final http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Basic ' +
              base64Encode(utf8.encode('$consumerKey:$consumerSecret')),
        },
      );

      if (response.statusCode == 200) {
        dynamic customData = json.decode(response.body);
        print('Custom API Results: $customData');
        // Process custom API response data
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Categories'),
          backgroundColor: Color(0xFF6a9739),
        ),
        body: Container(
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                flex: 3, // Represents 20% of the available space
                child: Container(
                  color: Colors.grey[50],
                  child: ListView.separated(
                    itemCount: categories.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(color: Colors.grey[200]),
                    itemBuilder: (BuildContext context, int index) {
                      var imageUrl = categories[index]['image'] != null
                          ? categories[index]['image']['src']
                          : '';

                      return InkWell(
                        onTap: () {
                          handleCategoryTap(index, categories[index]['id']);
                        },
                        child: Container(
                          color: selectedIndex == index ? Colors.white : null,
                          child: ListTile(
                            title: Column(
                              children: [
                                imageUrl.isNotEmpty
                                    ? Image.network(
                                        imageUrl,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      )
                                    : SizedBox(),
                                Text(categories[index]['name']),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 7, // Represents 80% of the available space
                child: Container(
                  child: Center(
                    child: Text('80% Content'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
