import 'package:datingapp/pages/components/my_input.dart';
import 'package:datingapp/pages/home.dart';
import 'package:datingapp/pages/login.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  final passwordController = TextEditingController(text: "*********");
  final confirmpasswordController = TextEditingController(text: "*********");
  bool is2FAEnabled = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
          width: double.infinity,
          padding: EdgeInsets.only(right: 40),
          child: Text(
            'Setting',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.black87),
            textAlign: TextAlign.center,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Colors.black), // Set the back arrow color to black
          onPressed: () {},
        ),
        // backgroundColor: Color(0xFF6a9739),
      ),
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              'Update Password',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'New Password', // Your label text here
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 8),
                            TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade200,
                                      )),
                                  // labelText: 'Mobile Number',
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(color: Colors.grey)),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "*********",
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.w300)),
                            ),
                            SizedBox(height: 15),
                            Text(
                              'Confirm Password',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 8),
                            TextField(
                              controller: confirmpasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade200,
                                      )),
                                  // labelText: 'Mobile Number',
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(color: Colors.grey)),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "*********",
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.w300)),
                            ),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Enable/Disable 2FA',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Switch(
                                  value: is2FAEnabled,
                                  onChanged: (bool value) {
                                    setState(() {
                                      is2FAEnabled = value;
                                    });
                                  },
                                  activeColor: Colors.pink,
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            ElevatedButton(
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all<Size?>(
                                    const Size(250.0, 55.0)),
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    const Color.fromRGBO(246, 46, 108, 1)),
                                foregroundColor: MaterialStateProperty.all<Color>(
                                    Colors.white),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        30.0), // Set your desired border radius here
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Home()),
                                );
                              },
                              child: const Text(
                                'UPDATE SETTING',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 16),
                              ),
                            ),
                          ]),
                    ),
                  ),
            
                  // SizedBox(
                  //   height: 8,
                  // ),
            
                  // SizedBox(
                  //   height: 8,
                  // ),
                ]),
          )),
    );
  }
}
