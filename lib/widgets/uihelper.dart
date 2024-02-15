import 'package:flutter/material.dart';

class UiHelper{

  static CustomTextField(TextEditingController controller,String text , IconData iconData,bool obsecureText){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
      child: TextField(
        controller: controller,
        obscureText: obsecureText,
        decoration: InputDecoration(
          hintText: text,
          suffixIcon: Icon(iconData),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          )
        ),
      ),
    );
  }
}