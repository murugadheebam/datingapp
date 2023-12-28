import 'package:flutter/material.dart';
import 'sidemenu.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      drawer: Sidemenu(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Find a Match',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              width: 200, // Set your desired width here
              child: Text(
                'Based on who you really are and what you love.',
                style: TextStyle(fontSize: 18),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 20),
            Card(
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Interest in',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        // Add more interest-related content here
                        Divider(), // Add a divider for visual separation
                        Row(
                          children: [
                            Radio(
                              value: 'men',
                              groupValue: selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  selectedGender = value.toString();
                                });
                              },
                            ),
                            Text('Men'),
                            SizedBox(width: 20),
                            Radio(
                              value: 'women',
                              groupValue: selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  selectedGender = value.toString();
                                });
                              },
                            ),
                            Text('Women'),
                            SizedBox(width: 20),
                            Radio(
                              value: 'other',
                              groupValue: selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  selectedGender = value.toString();
                                });
                              },
                            ),
                            Text('Other'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Interest in',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        // Add more interest-related content here
                        Divider(), // Add a divider for visual separation
                        Row(
                          children: [
                            Radio(
                              value: 'men',
                              groupValue: selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  selectedGender = value.toString();
                                });
                              },
                            ),
                            Text('Men'),
                            SizedBox(width: 20),
                            Radio(
                              value: 'women',
                              groupValue: selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  selectedGender = value.toString();
                                });
                              },
                            ),
                            Text('Women'),
                            SizedBox(width: 20),
                            Radio(
                              value: 'other',
                              groupValue: selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  selectedGender = value.toString();
                                });
                              },
                            ),
                            Text('Other'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
