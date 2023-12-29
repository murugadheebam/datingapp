import 'package:flutter/material.dart';

class MyInput extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final prefixicon;
  const MyInput(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.obscureText, this.prefixicon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextField(
      controller: controller,
      obscureText: obscureText,
      
      decoration: InputDecoration(
        prefixIcon: prefixicon,
         isDense: true,
         contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide(
            color: Colors.grey.shade200,
          )),
          // labelText: 'Mobile Number',
          focusedBorder:
              OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),borderSide: BorderSide(color: Colors.grey)),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w300
          )),
    ));
  }
}
