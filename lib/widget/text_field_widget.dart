import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  const CustomField({Key? key,
    required this.controller,
    this.maxLines,
    required this.hintText}) : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:controller ,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: Colors.black38
            )
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: Colors.black38
            )
        ),

      ),
      validator: (value){
        if(value==null || value.isEmpty){
          return "Enter your $hintText";
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}