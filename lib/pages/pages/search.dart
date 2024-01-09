import 'package:flutter/material.dart';
import 'sidemenu.dart';
import 'dashboard.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String? selectedGender;
  RangeValues height = RangeValues(25, 75); // Initial range values
  RangeValues age = RangeValues(25, 75); // Initial range values
  RangeValues weight = RangeValues(25, 75); // Initial range values

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      drawer: Sidemenu(),
      body: SingleChildScrollView(
        child: Container(
            height: size.height,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topRight, colors: [
            const Color(0xFAFAFB),
            const Color(0xE6C4D0).withOpacity(0.8)
          ])),
          child: Column(
            children: [
              Image.asset("assets/icon/hearts.svg"),
              Text(
                'Find a Match',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 9, 94, 136)),
              ),
              SizedBox(height: 10),
              Container(
                width: 200, // Set your desired width here
                child: Text(
                  'Based on who you really are and what you love.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 25),
              Card(
                color: Colors.white,
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(10),
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
                              'Height',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            // Add more interest-related content here
                            SliderTheme(
                              data: SliderThemeData(
                                trackHeight:
                                    4, // Adjust this value to make the slider thinner or thicker
                                activeTrackColor: Color(0xFFff0068),
                                inactiveTrackColor: Colors.grey,
                                thumbColor:
                                    Colors.white, // Modify thumb color as needed
                                overlayColor: Colors
                                    .transparent, // Set overlay color to transparent if not needed
                                valueIndicatorColor: Colors
                                    .blue, // Adjust value indicator color if used
                              ),
                              child: RangeSlider(
                                values: height,
                                min: 0,
                                max: 100,
                                divisions: 10,
                                labels: RangeLabels(
                                  height.start.round().toString(),
                                  height.end.round().toString(),
                                ),
                                onChanged: (RangeValues newValues) {
                                  setState(() {
                                    height = newValues;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Weight',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            SliderTheme(
                              data: SliderThemeData(
                                trackHeight:
                                    4, // Adjust this value to make the slider thinner or thicker
                                activeTrackColor: Color(0xFFff0068),
                                inactiveTrackColor: Colors.grey,
                                thumbColor:
                                    Colors.white, // Modify thumb color as needed
                                overlayColor: Colors
                                    .transparent, // Set overlay color to transparent if not needed
                                valueIndicatorColor: Colors
                                    .blue, // Adjust value indicator color if used
                              ),
                              child: RangeSlider(
                                values: weight,
                                min: 0,
                                max: 100,
                                divisions: 10,
                                labels: RangeLabels(
                                  weight.start.round().toString(),
                                  weight.end.round().toString(),
                                ),
                                onChanged: (RangeValues newValues) {
                                  setState(() {
                                    weight = newValues;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Age',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            SliderTheme(
                              data: SliderThemeData(
                                trackHeight:
                                    4, // Adjust this value to make the slider thinner or thicker
                                activeTrackColor: Color(0xFFff0068),
                                inactiveTrackColor: Colors.grey,
                                thumbColor:
                                    Colors.white, // Modify thumb color as needed
                                overlayColor: Colors
                                    .transparent, // Set overlay color to transparent if not needed
                                valueIndicatorColor: Colors
                                    .blue, // Adjust value indicator color if used
                              ),
                              child: RangeSlider(
                                values: age,
                                min: 0,
                                max: 100,
                                divisions: 10,
                                labels: RangeLabels(
                                  age.start.round().toString(),
                                  age.end.round().toString(),
                                ),
                                onChanged: (RangeValues newValues) {
                                  setState(() {
                                    age = newValues;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Dashboard()),
                          );
                        },
                        child: Text('SEARCH PEOPLE'),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Color(0xFFff0068)),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.white), // Text color
                          // Change background color here
                        ),
                      ),
                      SizedBox(height: 15)
                    ],
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
