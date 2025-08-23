import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomForm extends StatelessWidget {
  const CustomForm({
    super.key,
    required this.darkTheme, this.onChanged, this.hintText, this.prefixIcon, this.validator, this.obscureText = false, this.limit, this.suffixIcon, required this.controller
  });
  final Function(String)? onChanged;
  final String? hintText;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final bool obscureText;
  final int? limit;
  final Widget? suffixIcon;
  final TextEditingController controller;

  final bool darkTheme;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      obscureText: obscureText,
      
      inputFormatters: [
        LengthLimitingTextInputFormatter(limit ?? 50)
      ],
      decoration: InputDecoration(
        hintText: hintText,
        
        hintStyle: TextStyle(
          color: Colors.grey
        ),
        filled: true,
        fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none
          ),
        ),
        prefixIcon:prefixIcon, //?? Icon(Icons.person, color: darkTheme ? Colors.amber.shade400 : Colors.grey,) ,
        suffixIcon: suffixIcon
        
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onChanged: onChanged,
    );
  }
}
