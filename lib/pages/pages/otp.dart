import 'package:datingapp/pages/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'provider.dart';
import 'dart:convert';
import 'dart:async';

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
  late Timer _timer;
  int _secondsRemaining = 900; // 15 minutes in seconds

  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  bool isLoading = true;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer.cancel(); // Stop the timer when it reaches 0
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  // verify function
  Future<void> Checkotp(BuildContext context, WidgetRef ref) async {
    String emailOtp =
        emailotpcontrollers.map((controller) => controller.text).join();
    String mobileOtp =
        mobileotpcontrollers.map((controller) => controller.text).join();
    Map<String, dynamic>? data;
    final userData = ref.watch(userProvider);

    if (userData != null) {
      String jsonString = jsonEncode(userData);
      data = jsonDecode(jsonString);
    }
    isLoading = true;
    showLoader(context);

    final Uri url = Uri.parse(
        'https://commitment.loveyourselfblog.in/api/v1/auth/otp/verify');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'emailOTP': emailOtp,
          'phoneOTP': mobileOtp,
          'id': data?['id'],
          'device': '123'
        }),
      );
      print(emailOtp);
      print(mobileOtp);
      if (response.statusCode == 200) {
        await Future.delayed(Duration(seconds: 1));
        Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
        isLoading = false;
        print(response.body);
        ref.read(isLoggedInProvider.notifier).state = true;
        final prefs = ref.read(sharedPreferencesProvider);
        prefs.setBool('isLoggedIn', true);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Dashboard()),
            (Route<dynamic> route) => false);
      } else {
        await Future.delayed(Duration(seconds: 1));
        Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
        isLoading = false;
        await Future.delayed(Duration(seconds: 1));
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
    _timer.cancel();
    super.dispose();
  }

  showLoader(context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          key: _keyLoader,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Colors.pink,
                ),
                SizedBox(width: 20),
                Text("Please Wait..."),
              ],
            ),
          ),
        );
      },
    );
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
            children: [
              Image.asset(
                'assets/otp-new.png',
                width: 300,
                height: 200,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    children: [
                      Text(
                        'We have sent you a 6 digit verification code on Your Mobile and Email',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 10),
                      // OTP input fields
                      Text('Mobile OTP', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                            6, (index) => _buildMobileOTPBox(index)),
                      ),

                      SizedBox(height: 15),
                      const Divider(
                        height: 20,
                        thickness: 1,
                        indent: 20,
                        endIndent: 0,
                        color: Colors.black12,
                      ),
                      SizedBox(height: 10),
                      Text('Email OTP', style: TextStyle(fontSize: 18)),
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
                        child: Text(formatTime(
                            _secondsRemaining)), // You'll need to implement a timer logic
                      ),
                      if (_secondsRemaining < 0)
                        TextButton(
                          onPressed: () {},
                          child: Text('Resend',
                              style: TextStyle(color: Colors.pink)),
                          style: ElevatedButton.styleFrom(// Background color
                              ),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Resend button
              Consumer(builder: (context, ref, child) {
                return ElevatedButton(
                  onPressed: () {
                    Checkotp(context, ref);
                  },
                  child:
                      Text('Continue', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                   fixedSize: Size(160, 50), 
                  //  maximumSize: Size.fromWidth(300),
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
