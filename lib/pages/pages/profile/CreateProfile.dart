import 'dart:convert';
import 'dart:io';

import 'package:datingapp/pages/components/dateInput.dart';
import 'package:datingapp/pages/components/inputBox2.dart';
import 'package:datingapp/pages/components/my_input.dart';
import 'package:datingapp/pages/constants.dart';
import 'package:datingapp/pages/home.dart';
import 'package:datingapp/pages/login.dart';
import 'package:datingapp/pages/services/getLocalData.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:datingapp/pages/pages/notifications.dart';
import 'package:flutter/widgets.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

final dio = Dio();

class CreateProfile extends StatefulWidget {
  const CreateProfile({Key? key}) : super(key: key);

  @override
  CreateProfileState createState() => CreateProfileState();
}

class CreateProfileState extends State<CreateProfile> {
  final List<DropDownValueModel> occupationList = [];
  final List<DropDownValueModel> ethnicityList = [];
  final List<DropDownValueModel> intrestList = [];

  final issuesController = TextEditingController();

  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final dobController = TextEditingController();
  late SingleValueDropDownController ethnicityController;
  late SingleValueDropDownController occupationController;
  late SingleValueDropDownController genderController;
  late MultiValueDropDownController intrestsController;
  List<File?> selectedImages = List.generate(6, (_) => null);
  List intrestListvalue = [];

  get http => null;

  String userToken = "";

  @override
  void initState() {
    ethnicityController = SingleValueDropDownController();
    occupationController = SingleValueDropDownController();
    genderController = SingleValueDropDownController();
    intrestsController = MultiValueDropDownController();
    getUser();
    getUserToken();
    getOccupation();
    getEthnicity();
    getIntrest();
    super.initState();
  }

  getUser() async {
    Map<String, dynamic> userData = await getUserDataFromLocalStorage();
    print(userData);
  }

  Future getProfile() async {
    final url = ApiConstants.baseUrl + '/profile';
    final _headers = {
      "Authorization": userToken,
    };
    try {
      final response = await dio.get(
        url,
        options: Options(headers: _headers),
      );
    } catch (e) {
      print(e);
    }
  }

  getUserToken() async {
    String token = await getToken();
    setState(() {
      userToken = "Bearer " + token;
    });
  }

  Future<List> getIntrest() async {
    final queryParameters = {
      "jsonrpc": "2.0",
      "method": "getMasterchainInfo",
      "params": [],
      "id": "getblock.io"
    };
    final url = 'https://commitment.loveyourselfblog.in/api/v1/interest/list';
    try {
      final response = await dio.request(
        url,
        data: queryParameters,
        options: Options(method: 'GET'),
      );
      List<dynamic> items = response?.data['data'];
      updateDropDownList(items, intrestList);
      print("profile intrest api1");
      print(items);
      return items;
    } catch (e) {
      // print("profile api error");
      print(e);
      return [];
    }
  }

  Future<List> getOccupation() async {
    final queryParameters = {
      "jsonrpc": "2.0",
      "method": "getMasterchainInfo",
      "params": [],
      "id": "getblock.io"
    };
    final url = 'https://commitment.loveyourselfblog.in/api/v1/occupation/list';
    try {
      final response = await dio.request(
        url,
        data: queryParameters,
        options: Options(method: 'GET'),
      );
      List<dynamic> items = response?.data['data'];
      updateDropDownList(items, occupationList);
      print("profile api1");
      return items;
    } catch (e) {
      print("profile api error");
      print(e);
      return [];
    }
  }

  Future<List> getEthnicity() async {
    final queryParameters = {
      "jsonrpc": "2.0",
      "method": "getMasterchainInfo",
      "params": [],
      "id": "getblock.io"
    };
    final url = 'https://commitment.loveyourselfblog.in/api/v1/ethinicty/list';
    try {
      final response = await dio.request(
        url,
        data: queryParameters,
        options: Options(method: 'GET'),
      );
      List<dynamic> items = response?.data['data'];
      updateDropDownList(items, ethnicityList);
      print("profile api1");
      return items;
    } catch (e) {
      print("profile api error");
      print(e);
      return [];
    }
  }

  void updateDropDownList(List<dynamic> items, type) {
    type.clear();
    for (var item in items) {
      print(item['id']);
      type.add(DropDownValueModel(name: item['name'], value: item['id']));
    }
  }

  Future<void> getImage(index) async {
    final returnimg =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    print(returnimg);
    setState(() {
      selectedImages[index] = File(returnimg!.path);
    });

    if (returnimg != null) {
      final url =
          'https://commitment.loveyourselfblog.in/api/v1/profile/image/upload';
      String fileName = returnimg.path.split('/').last;
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          returnimg.path,
          filename: fileName,
        ),
        "type": "additional",
      });
      try {
        Response response = await dio.post(
          url,
          data: formData,
          options: Options(
            headers: {
              'Authorization': userToken,
            },
          ),
        );
        print(response.data);
      } catch (error) {
        print("upload Error");
        print(error.toString());
      }
    }
  }

  Future _formSubmit() async {
    // print(intrestsController?.dropDownValueList);
    List tempIntrest = [];
    for (var item in intrestsController?.dropDownValueList ?? []) {
      tempIntrest.add(item?.value!);
    }
    final obj = {
      "height": heightController.text ?? '',
      "weight": weightController.text ?? '',
      "occupation_id": occupationController?.dropDownValue!.value ?? '',
      "ethinicity_id": ethnicityController?.dropDownValue!.value ?? '',
      "interests": tempIntrest ?? [],
      // "gender" : genderController.dropDownValue!.value ?? ''
    };
    final _headers = {
      "Authorization": userToken,
    };
    final formData = FormData.fromMap(obj);
  for (var element in formData.fields) {
      print('${element.key}: ${element.value}');

  }
    print(formData);
    try {
    final response = await dio.post(ApiConstants.baseUrl + '/profile',
        data: formData, options: Options(headers: _headers));
    print(response);
    } catch (e) {
      print(e); 
    }

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => Home()),
    // ); 
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
              'Create Profile',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.black87),
              textAlign: TextAlign.center,
            ),
          ),
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back,
          //       color: Colors.black), // Set the back arrow color to black
          //   onPressed: () {},
          // ),
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
                            getIntrest();
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
                            Text("Occupation"),
                            SizedBox(height: 5),
                            DropDownTextField(
                              clearOption: false,
                              enableSearch: false,
                              dropdownColor: Colors.white,
                              controller: occupationController,
                              textFieldDecoration: InputDecoration(
                                  hintText: 'Enter Occupation',
                                  hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16),
                                  isDense: true,
                                  labelStyle: TextStyle(fontSize: 12),
                                  contentPadding: EdgeInsets.only(left: 20),
                                  errorBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100)),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100)),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade200),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100)),
                                    borderSide: BorderSide(color: Colors.grey),
                                  )),
                              dropDownList: occupationList,
                              
                            ),
                            SizedBox(height: 8),
                            Text("Intrests"),
                            DropDownTextField.multiSelection(
                              controller: intrestsController,
                              textFieldDecoration: InputDecoration(
                                  hintText: 'Choose Intrest',
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16),
                                  isDense: true,
                                  labelStyle: const TextStyle(fontSize: 12),
                                  contentPadding:
                                      const EdgeInsets.only(left: 20),
                                  errorBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100)),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100)),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade200),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100)),
                                    borderSide: BorderSide(color: Colors.grey),
                                  )),
                              // displayCompleteItem: true,
                              submitButtonColor: Colors.pink,
                              submitButtonTextStyle:
                                  TextStyle(color: Colors.white),
                              // initialValue: const ["Guitarist"],
                              dropDownList: const [
                                DropDownValueModel(
                                    name: 'Guitarist',
                                    value:
                                        'a0f2f9bf-240c-4cde-aeb9-9ae9ede4f2bd'),
                                DropDownValueModel(
                                    name: 'Reading',
                                    value:
                                        'b8391681-a071-4673-ac49-b619a26ac7ad'),
                              ],
                              onChanged: (data) {
                                for (var value in data) {
                                    print(value?.value);
                                }
                              },
                            ),
                            SizedBox(height: 8),
                            Text("Ethnicity"),
                            SizedBox(height: 5),
                            DropDownTextField(
                              clearOption: false,
                              enableSearch: false,
                              dropdownColor: Colors.white,
                              controller: ethnicityController,
                              textFieldDecoration: InputDecoration(
                                  hintText: 'Enter Ethnicity',
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16),
                                  isDense: true,
                                  labelStyle: const TextStyle(fontSize: 12),
                                  contentPadding:
                                      const EdgeInsets.only(left: 20),
                                  errorBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100)),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100)),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade200),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100)),
                                    borderSide: BorderSide(color: Colors.grey),
                                  )),
                              dropDownList: ethnicityList,
                              onChanged: (val) {
                                try {
                                  // print(curentObj);
                                } catch (e) {
                                  print(e);
                                }
                              },
                            ),
                            SizedBox(height: 8),
                            Text("DOB"),
                            SizedBox(height: 5),
                            DateInput(
                              controller: dobController,
                              hintText: "DD/MM/YYYY",
                            ),
                            SizedBox(height: 8),
                            Text("Gender"),
                            SizedBox(height: 5),
                            DropdownInputBox(
                              ethnicityController: genderController,
                              dropdownList: const [
                                DropDownValueModel(name: 'Male', value: 'male'),
                                DropDownValueModel(
                                    name: 'Female', value: 'female'),
                                DropDownValueModel(
                                    name: 'other', value: 'other')
                              ],
                            ),
                          ]),
                    ),
                  ),
                  Card(
                    elevation: 0,
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
                                child: GestureDetector(
                                  onTap: () {
                                    getImage(0);
                                  },
                                  child: Container(
                                    height: 100,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        selectedImages[0] != null
                                            ? Image.file(
                                                selectedImages[0]!,
                                                fit: BoxFit.cover,
                                                height: 100,
                                                width: 100,
                                              )
                                            : Image.asset(
                                                'assets/images/profile_placeholder.jpg',
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: double.infinity,
                                              ),
                                        Icon(
                                          selectedImages[0] != null
                                              ? Icons.edit
                                              : Icons.add_circle,
                                          size: 30,
                                          color: Colors.white,
                                        ), // Plus button overlay
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    getImage(1);
                                  },
                                  child: Container(
                                    height: 100,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        selectedImages[1] != null
                                            ? Image.file(
                                                selectedImages[1]!,
                                                fit: BoxFit.cover,
                                                height: 100,
                                                width: 100,
                                              )
                                            : Image.asset(
                                                'assets/images/profile_placeholder.jpg',
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: double.infinity,
                                              ),
                                        Icon(
                                          selectedImages[1] != null
                                              ? Icons.edit
                                              : Icons.add_circle,
                                          size: 30,
                                          color: Colors.white,
                                        ), // Plus button overlay
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    getImage(2);
                                  },
                                  child: Container(
                                    height: 100,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        selectedImages[2] != null
                                            ? Image.file(
                                                selectedImages[2]!,
                                                fit: BoxFit.cover,
                                                height: 100,
                                                width: 100,
                                              )
                                            : Image.asset(
                                                'assets/images/profile_placeholder.jpg',
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: double.infinity,
                                              ),
                                        Icon(
                                          selectedImages[2] != null
                                              ? Icons.edit
                                              : Icons.add_circle,
                                          size: 30,
                                          color: Colors.white,
                                        ), // Plus button overlay
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Add more Expanded widgets for other images
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    getImage(3);
                                  },
                                  child: Container(
                                    height: 100,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        selectedImages[3] != null
                                            ? Image.file(
                                                selectedImages[3]!,
                                                fit: BoxFit.cover,
                                                height: 100,
                                                width: 100,
                                              )
                                            : Image.asset(
                                                'assets/images/profile_placeholder.jpg',
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: double.infinity,
                                              ),
                                        Icon(
                                          selectedImages[3] != null
                                              ? Icons.edit
                                              : Icons.add_circle,
                                          size: 30,
                                          color: Colors.white,
                                        ), // Plus button overlay
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    getImage(4);
                                  },
                                  child: Container(
                                    height: 100,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        selectedImages[4] != null
                                            ? Image.file(
                                                selectedImages[4]!,
                                                fit: BoxFit.cover,
                                                height: 100,
                                                width: 100,
                                              )
                                            : Image.asset(
                                                'assets/images/profile_placeholder.jpg',
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: double.infinity,
                                              ),
                                        Icon(
                                          selectedImages[4] != null
                                              ? Icons.edit
                                              : Icons.add_circle,
                                          size: 30,
                                          color: Colors.white,
                                        ), // Plus button overlay
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    getImage(5);
                                  },
                                  child: Container(
                                    height: 100,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        selectedImages[5] != null
                                            ? Image.file(
                                                selectedImages[5]!,
                                                fit: BoxFit.cover,
                                                height: 100,
                                                width: 100,
                                              )
                                            : Image.asset(
                                                'assets/images/profile_placeholder.jpg',
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: double.infinity,
                                              ),
                                        Icon(
                                          selectedImages[5] != null
                                              ? Icons.edit
                                              : Icons.add_circle,
                                          size: 30,
                                          color: Colors.white,
                                        ), // Plus button overlay
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Add more Expanded widgets for other images
                            ],
                          ),
                          // Add more Rows for additional images
                        ],
                      ),
                    ),
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0), // Set your desired border radius here
                        ),
                      ),
                    ),
                    onPressed: () {
                      _formSubmit();
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

class DropdownInputBox extends StatelessWidget {
  const DropdownInputBox({
    super.key,
    required this.ethnicityController,
    required this.dropdownList,
  });

  final SingleValueDropDownController ethnicityController;
  final List<DropDownValueModel> dropdownList;

  @override
  Widget build(BuildContext context) {
    return DropDownTextField(
      clearOption: false,
      enableSearch: false,
      dropdownColor: Colors.white,
      controller: ethnicityController,
      textFieldDecoration: InputDecoration(
          hintText: 'Gender',
          hintStyle: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
          isDense: true,
          labelStyle: const TextStyle(fontSize: 12),
          contentPadding: const EdgeInsets.only(left: 20),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            borderSide: BorderSide(color: Colors.red),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            borderSide: BorderSide(color: Colors.grey),
          )),
      dropDownList: dropdownList,
      onChanged: (val) {
        try {
          // print(curentObj);
        } catch (e) {
          print(e);
        }
      },
    );
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
