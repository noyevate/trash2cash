import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSearch extends StatelessWidget {
  const CustomSearch({
    super.key,
    this.onChanged, this.hintText, this.prefixIcon, this.validator, this.obscureText = false, this.limit, this.suffixIcon, this.controller, this.color
  });
  final Function(String)? onChanged;
  final String? hintText;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final bool obscureText;
  final int? limit;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final Color? color;

 

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        obscureText: obscureText,
        
        
        inputFormatters: [
          LengthLimitingTextInputFormatter(limit ?? 50)
        ],
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          hintStyle: TextStyle(
            color: Color(0xff49454F) ?? color,
            fontSize: 15.sp
          ),
          filled: true,
          fillColor:  Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: BorderSide.none,
          ),
          prefixIcon:prefixIcon, //?? Icon(Icons.person, color: darkTheme ? Colors.amber.shade400 : Colors.grey,) ,
          suffixIcon: suffixIcon
          
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}
