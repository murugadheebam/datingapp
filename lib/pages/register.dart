import 'package:datingapp/pages/components/my_input.dart';
import 'package:datingapp/pages/home.dart';
import 'package:datingapp/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'pages/otp.dart';
import 'pages/provider.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final mailidController = TextEditingController();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  bool isLoading = true;

  final passwordController = TextEditingController();

  Future<void> RegisterUser(BuildContext context, WidgetRef ref) async {
    print("check");
    showLoader(context);
    final String name = nameController.text;
    final String mobile_no = mobileController.text;
    final String email = mailidController.text;
    setState(() {
      isLoading = true;
    });
    final String password = passwordController.text;
    var body = json.encode({
      'name': name,
      'email': email,
      'phone': '+91' + mobile_no,
      'password': password,
      'retype_password': password
    });
    print('body:$body');
    final Uri url = Uri.parse(
        'https://commitment.loveyourselfblog.in/api/v1/auth/register');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );
      print("response.body");

      print(response.body);

      if (response.statusCode == 200) {
        Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
        final userData = json.decode(response.body);
        ref.read(userProvider.notifier).state = userData;
        final prefs = ref.read(sharedPreferencesProvider);
        prefs.setString('userData', json.encode(userData));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OTPScreen()),
        );
      } else {
        Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

        final ErrorResponse = json.decode(response.body);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(ErrorResponse['message']),
            backgroundColor:
                Colors.green.shade400, // Change the background color here

            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (error) {
      print('name: $name');
      print("cgvdsfd");
      print('Error: $error');
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
          backgroundColor: Colors.red, // Change the background color here
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  showLoader(context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          key: _keyLoader,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Colors.pink,
                ),
                SizedBox(width: 20),
                Text("Please Wait..."),
              ],
            ),
          ),
        );
      },
    );
  }

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
              'Sign Up',
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
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          // backgroundColor: Color(0xFF6a9739),
        ),
        body: Stack(children: [
          Container(
            height: size.height,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topRight, colors: [
              const Color(0xfafafb),
              const Color(0xe6c4d0).withOpacity(0.8)
            ])),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/signup.png',
                    width: 300,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.all(30.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        MyInput(
                            controller: nameController,
                            hintText: "Name",
                            obscureText: false,
                            prefixicon: Icon(Icons.person_sharp)),
                        SizedBox(
                          height:
                              20, // Add more height here for additional space
                        ),
                        MyInput(
                            controller: mobileController,
                            hintText: "Phone Number",
                            obscureText: false,
                            prefixicon: Icon(Icons.phone_android)),
                        SizedBox(
                          height:
                              20, // Add more height here for additional space
                        ),
                        MyInput(
                            controller: mailidController,
                            hintText: "Email",
                            obscureText: false,
                            prefixicon: Icon(Icons.mail)),
                        SizedBox(
                          height:
                              20, // Add more height here for additional space
                        ),
                        MyInput(
                            controller: passwordController,
                            hintText: "Password",
                            obscureText: true,
                            prefixicon: Icon(Icons.lock)),
                        SizedBox(
                          height:
                              20, // Add more height here for additional space
                        ),
                        Consumer(builder: (context, ref, child) {
                          return ElevatedButton(
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size?>(
                                  const Size(250.0, 55.0)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromRGBO(246, 46, 108, 1)),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => OTPScreen()),
                              // );
                              RegisterUser(context, ref);
                            },
                            child: const Text(
                              'SIGN UP',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 16),
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: Text(
                      'Already have an account? Log In',
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          ),
        ]));
  }
}
