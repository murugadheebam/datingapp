import 'package:datingapp/pages/components/my_input.dart';
import 'package:datingapp/pages/home.dart';
import 'package:datingapp/pages/pages/account.dart';
import 'package:datingapp/pages/pages/dashboard.dart';
import 'package:datingapp/pages/register.dart';
import 'package:datingapp/pages/splashscreen.dart';
import 'package:flutter/material.dart';
import 'pages/otp.dart';
// import 'home.dart';
// import 'register.dart';
// import 'pages/dashboard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pages/provider.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> loginUser(BuildContext context, WidgetRef ref) async {
    print("check");
    final String email = emailController.text;
    final String password = passwordController.text;
    print(email);
    print(password);

    final Uri url =
        Uri.parse('https://commitment.loveyourselfblog.in/api/v1/auth/login');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          // Add any other required headers here
        },
        body: json
            .encode({'email': email, 'password': password, 'device': '289734'}),
      );
      print(response);
      if (response.statusCode == 200) {
        print(response.body);
        final userData = json.decode(response.body);
        ref.read(userProvider.notifier).state = userData;
        final prefs = ref.read(sharedPreferencesProvider);
        prefs.setString('userData', json.encode(userData));

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OTPScreen()),
        );
      }
    } catch (error) {
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
            'Login',
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
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                'assets/login_1.png',
                width: 300,
                height: 200,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                padding: const EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    MyInput(
                      controller: emailController,
                      hintText: "Email",
                      obscureText: false,
                      prefixicon: Icon(Icons.phone_android),
                    ),
                    const SizedBox(
                      height: 20, // Add more height here for additional space
                    ),
                    MyInput(
                        controller: passwordController,
                        hintText: "Password",
                        obscureText: true,
                        prefixicon: Icon(Icons.mail)),
                    const SizedBox(
                      height: 20, // Add more height here for additional space
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        return ElevatedButton(
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size?>(
                                const Size(250.0, 55.0)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(246, 46, 108, 1)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                          ),
                          onPressed: () {
                            loginUser(context, ref);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => OTPScreen()),
                            // );
                          },
                          child: const Text(
                            'LOGIN',
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 16),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const Register()), // Replace SignUp() with your signup page
                  );
                },
                child: const Text(
                  'Don\'t have an account? Sign Up',
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
