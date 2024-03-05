import 'package:datingapp/pages/components/inputBox2.dart';
import 'package:datingapp/pages/components/my_input.dart';
import 'package:datingapp/pages/home.dart';
import 'package:datingapp/pages/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:datingapp/pages/pages/notifications.dart';
import 'package:flutter/widgets.dart'; // Replace with your actual package name

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
        body: Container(
          height: size.height,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topRight, colors: [
            const Color(0xFAFAFB),
            const Color(0xE6C4D0).withOpacity(0.8)
          ])),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: [
                      // Profile Image
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/profile.png'),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'User Full Name',
                              style: TextStyle(
                                color: Colors.pink,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'username@gmail.com',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Edit Icon
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.pink,
                            width: 1, // Adjust border width as needed
                          ),
                        ),
                        padding: EdgeInsets.all(1), // Adjust padding as needed
                        child: IconButton(
                          padding: EdgeInsets.all(0),
                          icon: Icon(
                            Icons.edit,
                            color: Colors.pink, // Icon color
                          ),
                          iconSize: 15, // Adjust icon size as needed
                          onPressed: () {
                            // Add your edit functionality here
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
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
                            SizedBox(height: 10),
                            Text("Height"),
                            SizedBox(height: 5),
                            InputBox2(
                              controller: heightController,
                              hintText: "Enter Height",
                              obscureText: false,
                            ),
                            SizedBox(height: 8),
                            Text("Weight"),
                            SizedBox(height: 5),
                            InputBox2(
                              controller: weightController,
                              hintText: "Enter Weight",
                              obscureText: false,
                            ),
                            SizedBox(height: 8),
                            Text("Ethnicity"),
                            SizedBox(height: 5),
                            InputBox2(
                              controller: ethnicityController,
                              hintText: "Enter Ethnicity",
                              obscureText: false,
                            ),
                            SizedBox(height: 8),
                            Text("DOB"),
                            SizedBox(height: 5),
                            InputBox2(
                              controller: dobController,
                              hintText: "DD/MM/YYYY",
                              obscureText: false,
                            ),
                            SizedBox(height: 8),
                            Text("Gender"),
                            SizedBox(height: 5),
                            InputBox2(
                              controller: genderController,
                              hintText: "Male",
                              obscureText: false,
                            ),
                          ]),
                    ),
                  ),
                  Card(
                      elevation: 0,
                      child: Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Additional Pics",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                          height: 100,
                                          child: Image.asset(
                                            'assets/images/profile_placeholder.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: Icon(
                                            Icons.add_circle,
                                            size: 40,
                                            color: Colors.white,
                                          ), // Plus button overlay
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                          height: 100,
                                          child: Image.asset(
                                            'assets/images/profile_placeholder.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: Icon(
                                            Icons.add_circle,
                                            size: 40,
                                            color: Colors.white,
                                          ), // Plus button overlay
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                          height: 100,
                                          child: Image.asset(
                                            'assets/images/profile_placeholder.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: Icon(
                                            Icons.add_circle,
                                            size: 40,
                                            color: Colors.white,
                                          ), // Plus button overlay
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                          height: 100,
                                          child: Image.asset(
                                            'assets/images/profile_placeholder.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: Icon(
                                            Icons.add_circle,
                                            size: 40,
                                            color: Colors.white,
                                          ), // Plus button overlay
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                          height: 100,
                                          child: Image.asset(
                                            'assets/images/profile_placeholder.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: Icon(
                                            Icons.add_circle,
                                            size: 40,
                                            color: Colors.white,
                                          ), // Plus button overlay
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                          height: 100,
                                          child: Image.asset(
                                            'assets/images/profile_placeholder.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: Icon(
                                            Icons.add_circle,
                                            size: 40,
                                            color: Colors.white,
                                          ), // Plus button overlay
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size?>(
                          const Size(250.0, 55.0)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromRGBO(246, 46, 108, 1)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                    ),
                  ),
                ]),
          ),
        ));
  }
}

class ImageUploadGrid extends StatelessWidget {
  final List<String> images = [
    'image1.jpg', // Paths to your placeholder images
    'image2.jpg',
    'image3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: images.length + 1, // Plus one for the add button
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (BuildContext context, int index) {
        if (index == images.length) {
          // Add button
          return IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Add your logic for image selection/upload here
            },
          );
        } else {
          // Placeholder image
          return Stack(
            alignment: Alignment.center,
            children: [
              Placeholder(
                fallbackHeight: 70,
              ), // Placeholder image
              Positioned.fill(
                child: Icon(
                  Icons.add_circle,
                  size: 40,
                  color: Colors.white,
                ), // Plus button overlay
              ),
            ],
          );
        }
      },
    );
  }
}
