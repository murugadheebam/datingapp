import 'package:datingapp/pages/components/my_input.dart';
import 'package:datingapp/pages/home.dart';
import 'package:datingapp/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:datingapp/pages/pages/notifications.dart'; // Replace with your actual package name

class CreateProfile extends StatefulWidget {
  const CreateProfile({Key? key}) : super(key: key);

  @override
  CreateProfileState createState() => CreateProfileState();
}

class CreateProfileState extends State<CreateProfile> {
  final issuesController = TextEditingController();

  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final ethnicityController = TextEditingController();
  final dobController = TextEditingController();
  final genderController = TextEditingController();

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
            'Create Profile',
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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Notificationpage()),
              );
            },
          ),
        ],
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
                          'Physical Information', // Your label text here
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text("Height"),
                        MyInput(
                          controller: heightController,
                          hintText: "Enter Height",
                          obscureText: false, 
                        ),
                        SizedBox(height: 8),
                        Text("Weight"),
                        MyInput(
                          controller: weightController,
                          hintText: "Enter Weight",
                          obscureText: false, 
                        ),
                        SizedBox(height: 8),
                        Text("Ethnicity"),
                        MyInput(
                          controller: ethnicityController,
                          hintText: "Enter Ethnicity",
                          obscureText: false, 
                        ),
                        SizedBox(height: 8),
                        Text("DOB"),
                        MyInput(
                          controller: dobController,
                          hintText: "DD/MM/YYYY",
                          obscureText: false, 
                        ),
                        SizedBox(height: 8),
                        Text("Gender"),
                        MyInput(
                          controller: genderController,
                          hintText: "Email",
                          obscureText: false, 
                        ),
                      ]),
                ),
              ),
              Card(
                elevation: 0,
                child: Padding(padding: EdgeInsets.all(10), 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Additional Pics",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),)
                  ],
                ),)
              ),
              SizedBox(height: 20),
                        ElevatedButton(
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size?>(
                                const Size(250.0, 55.0)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(246, 46, 108, 1)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
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
                            'Submit',
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 16),
                          ),
                        ),
            ]),
      )),
    );
  }
}
