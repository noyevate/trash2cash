import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/custom_form.dart';
import 'package:trash2cash/constants/others.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';
import 'package:trash2cash/constants/utils.dart';
import 'package:trash2cash/features/home_user/presentation/pages/successful_listing.dart';
import 'package:trash2cash/features/home_user/presentation/pages/widgets/create_list_appbar.dart';
import 'package:http/http.dart' as http;

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
    final wasteWeightTextEditingController = TextEditingController();

   final List<String> wasteTypes = ["Plastics", "Iron"];
  String? selectedWaste;
  File? image;

  Future<void> _uploadWaste(BuildContext context) async {
  String title = titleTextEditingController.text.trim();
  String wasteDesc = wasteDescTextEditingController.text.trim();
  String pickUp = pickupTextEditingController.text.trim();
  String phone = phoneTextEditingController.text.trim();
  String wasteType = selectedWaste ?? "PLASTIC"; // dropdown choice
  int? wasteUnit = int.tryParse(wasteUnitTextEditingController.text.trim());
double? wasteWeight = double.tryParse(wasteWeightTextEditingController.text.trim());

  if (title.isEmpty ||
      wasteDesc.isEmpty ||
      pickUp.isEmpty ||
      phone.isEmpty ||
      wasteUnit!.isNaN ||
      wasteWeight!.isNaN ||
      image == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please fill all fields and select an image")),
    );
    return;
  }

  try {
    
    var uri = Uri.parse("https://$appBaseUrl"); // change to your endpoint

    var request = http.MultipartRequest("POST", uri);

    // Add fields
    request.fields["title"] = title;
    request.fields["description"] = wasteDesc;
    request.fields["pickupLocation"] = pickUp;
    request.fields["type"] = wasteType.toUpperCase();
    request.fields["unit"] = wasteUnit.toString();
    request.fields["weight"] = wasteWeight.toString(); // you can change to actual value
    request.fields["contactPhone"] = phone;

    // Add image
    request.files.add(await http.MultipartFile.fromPath("image", image!.path));

    // If you need token authentication
    // request.headers["Authorization"] = "Bearer $accessToken";

    var response = await request.send();

    if (response.statusCode == 201 || response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Waste uploaded successfully ✅")),
      );
      // clear form
      titleTextEditingController.clear();
      wasteDescTextEditingController.clear();
      pickupTextEditingController.clear();
      phoneTextEditingController.clear();
      wasteUnitTextEditingController.clear();
      image = null;
    } else {
      var respStr = await response.stream.bytesToString();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed: $respStr")),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: $e")),
    );
  }
}

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }
  bool _isLoading = false;

  void _handleTap() {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SuccessfulListing(),
        ),
      );
    });
  }

  
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
                  controller: wasteUnitTextEditingController,
                  
                ),
                5.l,
                RText(
                    title: "Waste Weight(in kg)",
                    style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500)),
                CustomForm(
                  darkTheme: false,
                  prefixIcon: null,
                  
                  hintText: "Enter waste unit",
                  controller: wasteWeightTextEditingController,
                  
                ),
                5.l,

                RText(
                    title: "Upload image",
                    style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500)),
                image != null ?
                SizedBox(
                  height: 200.h,
                    width: 500.h,
                    child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                child: Image.file(
                                  image!,
                                  fit: BoxFit.cover,
                                )),
                ):
                GestureDetector(
                  onTap: selectImage,
                  child: Container(
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
                )  ,

                10.l,

                GestureDetector(
                  onTap: _isLoading ? null : _handleTap,
                  child: Container(
                    height: 60.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Tcolor.PrimaryYellow,
                        borderRadius: BorderRadius.circular(30.r)),
                    child:  Center(
                      child: _isLoading ? SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                ): RText(
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