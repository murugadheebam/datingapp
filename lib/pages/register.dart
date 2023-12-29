import 'package:datingapp/pages/components/my_input.dart';
import 'package:datingapp/pages/home.dart';
import 'package:datingapp/pages/login.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final mailidController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          padding: EdgeInsets.only(right: 40),
          child: Text(
            'Sign Up',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 25,
                color: Colors.black87),
            textAlign: TextAlign.center,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                'assets/login.png',
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
                    color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    MyInput(
                        controller: nameController,
                        hintText: "Full Name",
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
                        hintText: "Phone Number",
                        obscureText: false,
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                      },
                      child: const Text(
                        'SIGN UP',
                        style:
                            TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20, // Add more height here for additional space
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                child: Text('Already have an account? Log In', 
                  style: TextStyle(color: Colors.black54, fontSize: 16),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
