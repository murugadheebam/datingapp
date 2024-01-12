import 'package:flutter/material.dart';

class MyInput extends StatefulWidget {

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
  State<MyInput> createState() => _MyInputState();
}

class _MyInputState extends State<MyInput> {
    bool _isObscure = true;
   void _toggleObscured() {
    setState(() {
      _isObscure = !_isObscure;     // Prevents focus if tap on eye
    });
  }
  @override
  Widget build(BuildContext context) {
    
    return Container(
        child: TextField(
      controller: widget.controller,
      obscureText:widget.obscureText ? _isObscure : false,
      
      decoration: InputDecoration(
        prefixIcon: widget.prefixicon,
        suffixIcon: widget.obscureText
              ? IconButton(
                  onPressed: () {_toggleObscured(); },
                  icon: _isObscure ? Icon(Icons.visibility_off): Icon(Icons.visibility) ,
                )
              : null,
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
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w300
          )),
    ));
  }
}
