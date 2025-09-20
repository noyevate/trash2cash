import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomForm extends StatelessWidget {
  const CustomForm({
    super.key,
    required this.darkTheme, this.onChanged, this.hintText, this.keyboardType, this.prefixIcon, this.validator, this.obscureText = false, this.limit, this.suffixIcon, this.controller, this.color, this.readOnly
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
  final TextInputType? keyboardType;

  final bool darkTheme;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.emailAddress,
        obscureText: obscureText,
        readOnly: readOnly ?? false,
        
        
        inputFormatters: [
          LengthLimitingTextInputFormatter(limit ?? 50)
        ],
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          hintStyle: TextStyle(
            color: color ?? Color(0xff49454F),
            fontSize: 15.sp
          ),
          filled: true,
          fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
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
