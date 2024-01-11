import 'package:datingapp/pages/components/my_input.dart';
import 'package:datingapp/pages/home.dart';
import 'package:datingapp/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'pages/otp.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final mailidController = TextEditingController();
    bool isLoading = false;


  final passwordController = TextEditingController();

  Future<void> RegisterUser(BuildContext context) async {
    print("check");
     setState(() {
    isLoading = true; // Start loading
  });
    final String name = nameController.text;
    final String mobile_no = mobileController.text;
    final String email = mailidController.text;

    final String password = passwordController.text;

    final Uri url = Uri.parse(
        'https://commitment.loveyourselfblog.in/api/v1/auth/register');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          // Add any other required headers here
        },
        body: json.encode({
          'name': name,
          'email': email,
          'phone': '+91' + mobile_no,
          'password': password,
          'retype_password': password
        }),
      );
      print(response);
      if (response.statusCode == 200) {
        setState(() {
      isLoading = false; // Stop loading after API call is done
    });
        print(response.body);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OTPScreen()),
        );
      }else{}
    } catch (error) {
      setState(() {
      isLoading = false; // Stop loading after API call is done
    });
      // Handle any exceptions that might occur during the API call
      print("cgvdsfd");
      print('Error: $error');
    }
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
      body: Stack(
        children: [ 
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
                      height: 20, // Add more height here for additional space
                    ),
                    MyInput(
                        controller: mobileController,
                        hintText: "Phone Number",
                        obscureText: false,
                        prefixicon: Icon(Icons.phone_android)),
                    SizedBox(
                      height: 20, // Add more height here for additional space
                    ),
                    MyInput(
                        controller: mailidController,
                        hintText: "Email",
                        obscureText: false,
                        prefixicon: Icon(Icons.mail)),
                    SizedBox(
                      height: 20, // Add more height here for additional space
                    ),
                    MyInput(
                        controller: passwordController,
                        hintText: "Password",
                        obscureText: true,
                        prefixicon: Icon(Icons.mail)),
                    SizedBox(
                      height: 20, // Add more height here for additional space
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size?>(
                            const Size(250.0, 55.0)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromRGBO(246, 46, 108, 1)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => OTPScreen()),
                        // );
                        RegisterUser(context);
                      },
                      child: const Text(
                        'SIGN UP',
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 16),
                      ),
                    ),
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
           if (isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5), // Semi-transparent overlay
                child: Center(
                  child: Image.asset('assets/loading-heart.gif'), // Loading GIF
                ),
              ),
            ),
        ]
      )
    );
  }
}
