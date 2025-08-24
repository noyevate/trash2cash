import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/custom_form.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';
import 'package:trash2cash/features/home_user/presentation/pages/widgets/create_list_appbar.dart';

class CreateWasteList extends StatefulWidget {
  const CreateWasteList({super.key});

  @override
  State<CreateWasteList> createState() => _CreateWasteListState();
}

class _CreateWasteListState extends State<CreateWasteList> {
  final titleTextEditingController = TextEditingController();
    final wasteDescTextEditingController = TextEditingController();
    final pickupTextEditingController = TextEditingController();
    final phoneTextEditingController = TextEditingController();
    final wasteTypeTextEditingController = TextEditingController();
    final wasteUnitTextEditingController = TextEditingController();

   final List<String> wasteTypes = ["Plastics", "Iron"];
  String? selectedWaste;
  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(preferredSize: Size.fromHeight(100.h), child: CreateListAppbar()),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RText(
                    title: "Title",
                    style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500)),
                CustomForm(
                  darkTheme: false,
                  prefixIcon: null,
                  hintText: "Enter your title here",
                  controller: titleTextEditingController,
                  
                ),
                5.l,

                RText(
                    title: "Waste Description",
                    style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500)),
                CustomForm(
                  darkTheme: false,
                  prefixIcon: null,
                  
                  hintText: "Enter your title here",
                  controller: wasteDescTextEditingController,
                  
                ),
                5.l,

                RText(
                    title: "Pickup",
                    style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500)),
                CustomForm(
                  darkTheme: false,
                  prefixIcon: null,
                  
                  hintText: "Enter your title here",
                  controller: pickupTextEditingController,
                  
                ),
                5.l,

                RText(
                    title: "Phone number",
                    style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500)),
                CustomForm(
                  darkTheme: false,
                  prefixIcon: null,
                  
                  hintText: "Enter your title here",
                  controller: phoneTextEditingController,
                  
                ),
                5.l,
                RText(
                    title: "Type of waste",
                    style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500)),
                    CustomForm(
                darkTheme: false,
                prefixIcon: null,
                hintText: "Select waste type",
                controller: wasteTypeTextEditingController,
                readOnly: true, // prevent typing
                suffixIcon: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    dropdownColor: Colors.white,
                    value: selectedWaste,
                    icon: const Icon(Icons.arrow_drop_down_outlined, color: Colors.black),
                    items: wasteTypes.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 41, 41, 41),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedWaste = newValue;
                        wasteTypeTextEditingController.text = newValue ?? "";
                      });
                    },
                  ),
                ),
              ),

              5.l,

                RText(
                    title: "Waste Unit",
                    style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500)),
                CustomForm(
                  darkTheme: false,
                  prefixIcon: null,
                  
                  hintText: "Enter waste unit",
                  controller: phoneTextEditingController,
                  
                ),
                5.l,
                RText(
                    title: "Waste Weight(in kg)",
                    style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500)),
                CustomForm(
                  darkTheme: false,
                  prefixIcon: null,
                  
                  hintText: "Enter waste unit",
                  controller: phoneTextEditingController,
                  
                ),
                5.l,

                RText(
                    title: "Upload image",
                    style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500)),
                Container(
                  height: 200.h,
                  width: 500.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20.r)
                  ),
                  child: Center(child: RText(
                    title: "Upload image",
                    style: TextStyle(color: Color(0xff49454F), fontSize: 15.sp, fontWeight: FontWeight.w400)),),
                ),

                10.l,

                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (BuildContext context) => RegisterPage()),
                    // );
                
                    // print(passwordTextEditingController.text);
                  },
                  child: Container(
                    height: 60.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Tcolor.PrimaryYellow,
                        borderRadius: BorderRadius.circular(30.r)),
                    child: Center(
                      child: RText(
                        title: "Submit",
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),

                 20.l,
                
            ],
          ),
        ),
      ),
    );
  }
}