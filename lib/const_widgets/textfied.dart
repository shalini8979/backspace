
import 'package:flutter/material.dart';


class CustomTextFormField extends StatelessWidget{
  final TextEditingController controller;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool  readonly;
  final Function? ontap;
  final FormFieldValidator<String> validator;
  final String? errorText;

  CustomTextFormField({super.key, 

  required this.controller, 
  required this.hintText, 
  required this.prefixIcon, 
  required this.suffixIcon, 
  required this.obscureText,
  required this.readonly,
  required this.ontap, 
  required keyboardtype, 
  required this.errorText,

  required this.validator,  
  required Null Function(String value) onChanged, 
  required String labelText, 
  });

  @override
  Widget build(Object context) {
    return 
      TextFormField(
        controller: controller,
        cursorColor: Colors.purple,
        readOnly: readonly,
        keyboardType: null,
        cursorErrorColor: Colors.red,
        style:TextStyle(color: Colors.black),
        decoration: InputDecoration(
          error: null,
          
          constraints: const BoxConstraints( minHeight:30),
          contentPadding: EdgeInsets.symmetric(vertical:5,horizontal:10),
          border: OutlineInputBorder( 
            // borderRadius: BorderRadius.circular(0.0),
            borderSide:const BorderSide(
            color: Color.fromARGB(255, 124, 122, 122), // You can change the color as well
            width: 1.0,),
          
            
            ),
            focusedBorder: OutlineInputBorder( 
            // borderRadius: BorderRadius.circular(0),
            borderSide:const BorderSide(
            color: Colors.purple, // You can change the color as well
            width: 1.0,),
      
            
      
            ),
            errorBorder: OutlineInputBorder(
            // borderRadius: BorderRadius.circular(8),
            borderSide:const BorderSide(
            color: Color.fromARGB(255, 255, 66, 52), // You can change the color as well
            width: 1.0,),
      
            ),
      
            focusedErrorBorder: OutlineInputBorder(
              // borderRadius: BorderRadius.circular(8),
            borderSide:const BorderSide(
            color: Color.fromARGB(255, 255, 66, 52), // You can change the color as well
            width: 1.0,),
            ),
      
          labelStyle: TextStyle(color: Colors.grey),
          hintText: hintText,
          hintStyle:TextStyle(color:Color.fromARGB(255, 188, 188, 184)) ,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction, // Add this line
        obscureText: obscureText,
        validator: validator,
      //  ),
      
          );
    }
    
  }



