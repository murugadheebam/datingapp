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
  List<TextEditingController> emailotpcontrollers = List.generate(6, (index) => TextEditingController());
  List<FocusNode> emailotpfocusNodes = List.generate(6, (index) => FocusNode());

  List<TextEditingController> mobileotpcontrollers = List.generate(6, (index) => TextEditingController());
  List<FocusNode> mobileotpfocusNodes = List.generate(6, (index) => FocusNode());


    Future<void> Checkotp(BuildContext context,WidgetRef ref) async {
        String emailOtp = emailotpcontrollers.map((controller) => controller.text).join();
  String mobileOtp = mobileotpcontrollers.map((controller) => controller.text).join();


      final Uri url = Uri.parse('https://commitment.loveyourselfblog.in/api/v1/auth/otp/verify');
    try {
          final userData = ref.watch(userProvider);
      String id = '';

if (userData != null) {
  String jsonString = jsonEncode(userData);
  Map<String, dynamic> data = jsonDecode(jsonString);

  String id1 = data['id'];
          print('ID: $id');

                final response = await http.post(
        url,
         headers: {
      'Content-Type': 'application/json',
      // Add any other required headers here
    },
        body: json.encode({
          'emailOTP':emailOtp,
          'phoneOTP': mobileOtp,
          'id':id,
          'device':'123'
          
         
        }),
        
      );
      print(response);
      if (response.statusCode == 200) {
        print(response.body);

        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
    
      }


} else {
  // Handle the case when userData is null
  print("else");
    String id ='';

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
        title: Text('OTP'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
         
                    Image.asset(
                'assets/login.png',
                width: 300,
                height: 200,
                fit: BoxFit.contain,
              ),
            Spacer(),
            Text(
              'We have sent you a 6 digit verification code on Your Mobile and Email',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
            ),
            Spacer(),
            // OTP input fields
            Text('Mobile OTP'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) =>  _buildMobileOTPBox(index)),
            ),
            Spacer(),
            Text('Email OTP'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) => _buildEmailOTPBox(index)), // Offset by 6 for different focus nodes and controllers
            ),
            Spacer(),
            // Timer text
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text('01:02'), // You'll need to implement a timer logic
            ),
            Spacer(),
            // Resend button
                                Consumer(
      builder: (context, ref, child) {
            return ElevatedButton(
              onPressed: () {
                // Handle resend OTP
                Checkotp(context,ref);
              },
              child: Text('RESEND OTP'),
              style: ElevatedButton.styleFrom(
                primary: Colors.pink, // Background color
              ),
            );
      }),
            Spacer(),
          ],
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
              FocusScope.of(context).requestFocus(emailotpfocusNodes[index + 1]);
            }
            if (value.isEmpty && !isFirst) {
              emailotpfocusNodes[index].unfocus();
              FocusScope.of(context).requestFocus(emailotpfocusNodes[index - 1]);
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
              FocusScope.of(context).requestFocus(mobileotpfocusNodes[index + 1]);
            }
            if (value.isEmpty && !isFirst) {
              mobileotpfocusNodes[index].unfocus();
              FocusScope.of(context).requestFocus(mobileotpfocusNodes[index - 1]);
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
