import 'package:datingapp/pages/components/my_input.dart';
import 'package:datingapp/pages/home.dart';
import 'package:datingapp/pages/pages/account.dart';
import 'package:datingapp/pages/pages/dashboard.dart';
import 'package:datingapp/pages/register.dart';
import 'package:datingapp/pages/splashscreen.dart';
import 'package:flutter/material.dart';
// import 'home.dart';
// import 'register.dart';
// import 'pages/dashboard.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

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
            const Color(0xfafafb),
            const Color(0xe6c4d0).withOpacity(0.8)
          ])),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                'assets/login.png',
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
                      controller: usernameController,
                      hintText: "Mobile Number",
                      obscureText: false,
                      prefixicon: Icon(Icons.phone_android),
                    ),
                    const SizedBox(
                      height: 20, // Add more height here for additional space
                    ),
                    MyInput(
                        controller: passwordController,
                        hintText: "Mail ID",
                        obscureText: false,
                        prefixicon: Icon(Icons.mail)),
                    const SizedBox(
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Dashboard()),
                        );
                      },
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 16),
                      ),
                    ),
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
