import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateInput extends StatefulWidget {

  final controller;
  final String hintText;
  final bool? obscureText;
  final dynamic? prefixicon;
  const DateInput(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.obscureText, this.prefixicon})
      : super(key: key);

  @override
  State<DateInput> createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
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
      readOnly: true,
      onTap: () async{
        DateTime? pickDate = await showDatePicker(context: context,initialDate: DateTime(1980), firstDate: DateTime(1980), lastDate: DateTime(2015), initialEntryMode: DatePickerEntryMode.calendarOnly,); 
        if(pickDate != null){
          widget.controller.text = DateFormat('DD/MM/yyyy').format(pickDate); 
        }
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.date_range),
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
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w300
          )),
    ));
  }
}
