import 'package:datingapp/pages/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'provider.dart';
import 'dart:convert';

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  List<TextEditingController> emailotpcontrollers =
      List.generate(6, (index) => TextEditingController());
  List<FocusNode> emailotpfocusNodes = List.generate(6, (index) => FocusNode());

  List<TextEditingController> mobileotpcontrollers =
      List.generate(6, (index) => TextEditingController());
  List<FocusNode> mobileotpfocusNodes =
      List.generate(6, (index) => FocusNode());

  Future<void> Checkotp(BuildContext context, WidgetRef ref) async {
    String emailOtp =
        emailotpcontrollers.map((controller) => controller.text).join();
    String mobileOtp =
        mobileotpcontrollers.map((controller) => controller.text).join();
    Map<String, dynamic>? data;
    final userData = ref.watch(userProvider);

    if (userData != null) {
      // Convert the userData map to a JSON string
      String jsonString = jsonEncode(userData);

      // Decode the JSON string to a Map
      data = jsonDecode(jsonString);

      // Now 'data' contains the decoded data from the 'userData' map
    }

    final Uri url = Uri.parse(
        'https://commitment.loveyourselfblog.in/api/v1/auth/otp/verify');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          // Add any other required headers here
        },
        body: json.encode({
          'emailOTP': emailOtp,
          'phoneOTP': mobileOtp,
          'id': data?['id'],
          'device': '123'
        }),
      );
      print(response);
      if (response.statusCode == 200) {
        print(response.body);
        ref.read(isLoggedInProvider.notifier).state = true;
        final prefs = ref.read(sharedPreferencesProvider);
        prefs.setBool('isLoggedIn', true);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
        );
      } else {
        print(response.body);
        final Map<String, dynamic> errorData = json.decode(response.body);
        final errorMessage = errorData['error_text'] ?? 'OTP does not match';

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red, // Change the background color here

            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (error) {
      // Handle any exceptions that might occur during the API call
      print("cgvdsfd");
      print('Error: $error');
    }
  }

  @override
  void dispose() {
    emailotpcontrollers.forEach((controller) => controller.dispose());
    emailotpfocusNodes.forEach((focusNode) => focusNode.dispose());

    mobileotpcontrollers.forEach((controller) => controller.dispose());
    mobileotpfocusNodes.forEach((focusNode) => focusNode.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
          width: double.infinity,
          padding: EdgeInsets.only(right: 40),
          child: Text(
            'OTP',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/otp-new.png',
                width: 300,
                height: 200,
                fit: BoxFit.contain,
              ),
              
              Text(
                'We have sent you a 6 digit verification code on Your Mobile and Email',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 10),
              // OTP input fields
              Text('Mobile OTP'),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) => _buildMobileOTPBox(index)),
              ),
              
              SizedBox(height: 10),
              Text('Email OTP'),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                    6,
                    (index) => _buildEmailOTPBox(
                        index)), // Offset by 6 for different focus nodes and controllers
              ),
              
              // Timer text
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text('01:02'), // You'll need to implement a timer logic
              ),
              
              // Resend button
              Consumer(builder: (context, ref, child) {
                return ElevatedButton(
                  onPressed: () {
                    // Handle resend OTP
                    Checkotp(context, ref);
                  },
                  child: Text('RESEND OTP', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink, // Background color
                  ),
                );
              }),
              
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailOTPBox(int index) {
    bool isFirst = index == 0;
    bool isLast = index == emailotpcontrollers.length - 1;

    return Container(
      width: 40,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: TextFormField(
          controller: emailotpcontrollers[index],
          focusNode: emailotpfocusNodes[index],
          autofocus: isFirst,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24),
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
          ],
          onChanged: (value) {
            if (value.length == 1 && !isLast) {
              emailotpfocusNodes[index].unfocus();
              FocusScope.of(context)
                  .requestFocus(emailotpfocusNodes[index + 1]);
            }
            if (value.isEmpty && !isFirst) {
              emailotpfocusNodes[index].unfocus();
              FocusScope.of(context)
                  .requestFocus(emailotpfocusNodes[index - 1]);
            }
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '0',
            hintStyle: TextStyle(color: Colors.grey.shade400),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileOTPBox(int index) {
    bool isFirst = index == 0;
    bool isLast = index == mobileotpcontrollers.length - 1;

    return Container(
      width: 40,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: TextFormField(
          controller: mobileotpcontrollers[index],
          focusNode: mobileotpfocusNodes[index],
          autofocus: isFirst,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24),
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
          ],
          onChanged: (value) {
            if (value.length == 1 && !isLast) {
              mobileotpfocusNodes[index].unfocus();
              FocusScope.of(context)
                  .requestFocus(mobileotpfocusNodes[index + 1]);
            }
            if (value.isEmpty && !isFirst) {
              mobileotpfocusNodes[index].unfocus();
              FocusScope.of(context)
                  .requestFocus(mobileotpfocusNodes[index - 1]);
            }
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '0',
            hintStyle: TextStyle(color: Colors.grey.shade400),
          ),
        ),
      ),
    );
  }
}
