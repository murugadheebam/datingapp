import 'package:datingapp/pages/components/my_input.dart';
import 'package:datingapp/pages/home.dart';
import 'package:datingapp/pages/login.dart';
import 'package:flutter/material.dart';

class Createevent extends StatefulWidget {
  const Createevent({Key? key}) : super(key: key);

  @override
  CreateeventState createState() => CreateeventState();
}

class CreateeventState extends State<Createevent> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final mailidController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay.now();
  TextEditingController _textAreaController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        _timeController.text =
            '${picked.hour}:${picked.minute} ${picked.period == DayPeriod.am ? 'AM' : 'PM'}';
      });
    }
  }

  @override
  void dispose() {
    _textAreaController.dispose();
    _timeController.dispose();
    dateController.dispose();
    super.dispose();
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
            'Create Event',
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
          padding: EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset(
                  'assets/login.png',
                  width: 300,
                  height: 200,
                  fit: BoxFit.contain,
                ),
                Text(
                  'Place', // Your label text here
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                // SizedBox(
                //   height: 8,
                // ),
                MyInput(
                    controller: nameController,
                    hintText: "Place",
                    obscureText: false,
                    prefixicon: Icon(Icons.person_sharp)),
                Text(
                  'Date', // Your label text here
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                // SizedBox(
                //   height: 8,
                // ),
                TextField(
                  controller: dateController,
                  onTap: () => _selectDate(context),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () => _selectDate(context),
                      icon: Icon(Icons.calendar_today),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: BorderSide(
                          color: Colors.grey.shade200,
                        )),
                  ),
                  readOnly: true, // To prevent manual text input
                ),
                Text(
                  'Time', // Your label text here
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                // SizedBox(
                //   height: 8,
                // ),
                TextField(
                  controller: _timeController,
                  onTap: () => _selectTime(context),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () => _selectTime(context),
                      icon: Icon(Icons.access_time),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: BorderSide(
                          color: Colors.grey.shade200,
                        )),
                  ),
                  readOnly: true,
                ),
                Text(
                  'Message', // Your label text here
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                // SizedBox(
                //   height: 8,
                // ),
                TextField(
                  controller: _textAreaController,
                  maxLines: null, // Allows for multiline input
                  decoration: InputDecoration(
                    hintText: 'Enter your text here',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: BorderSide(
                          color: Colors.grey.shade200,
                        )),
                  ),
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
                    'SCHEDULE EVENT',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                  ),
                ),
              ])),
    );
  }
}
