import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/custom_form.dart';
import 'package:trash2cash/constants/others.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';
import 'package:trash2cash/constants/utils.dart';
import 'package:trash2cash/features/home_user/presentation/pages/widgets/create_list_appbar.dart';
import 'package:http/http.dart' as http;
import 'package:trash2cash/features/waste/domain/entities/waste_listing.dart';
import 'package:trash2cash/features/waste/presentation/bloc/create_listing_bloc.dart';
import 'package:trash2cash/features/waste/presentation/widgets/successful_listing.dart';

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
  final typeTextEditingController = TextEditingController();
  final wasteUnitTextEditingController = TextEditingController();
  final wasteWeightTextEditingController = TextEditingController();

  final List<String> wasteTypes = ["PLASTIC", "METAL"];
  String? selectedWaste;
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  Type _wasteTypeFromString(String? value) {
    return Type.values.firstWhere(
      (type) => type.name == value,
      orElse: () => Type.PLASTIC, // Default fallback
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(90.h), child: CreateListAppbar()),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RText(
                    title: "Title",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500)),
                CustomForm(
                  darkTheme: false,
                  prefixIcon: null,
                  hintText: "Enter your title here",
                  controller: titleTextEditingController,
                ),
                5.l,
                RText(
                    title: "Waste Description",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500)),
                CustomForm(
                  darkTheme: false,
                  prefixIcon: null,
                  hintText: "Enter your title here",
                  controller: wasteDescTextEditingController,
                ),
                5.l,
                RText(
                    title: "Pickup",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500)),
                CustomForm(
                  darkTheme: false,
                  prefixIcon: null,
                  hintText: "Enter your title here",
                  controller: pickupTextEditingController,
                ),
                5.l,
                RText(
                    title: "Phone number",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500)),
                CustomForm(
                  darkTheme: false,
                  prefixIcon: null,
                  hintText: "Enter your phone number here",
                  controller: phoneTextEditingController,
                  keyboardType: TextInputType.numberWithOptions(),
                ),
                5.l,
                RText(
                    title: "Type of waste",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500)),
                CustomForm(
                  darkTheme: false,
                  prefixIcon: null,
                  hintText: "Select waste type",
                  controller: typeTextEditingController,
                  readOnly: true, // prevent typing
                  suffixIcon: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: Colors.white,
                      value: selectedWaste,
                      icon: const Icon(Icons.arrow_drop_down_outlined,
                          color: Colors.black),
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
                          typeTextEditingController.text = newValue ?? "";
                        });
                      },
                    ),
                  ),
                ),
                5.l,
                RText(
                    title: "Waste Unit",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500)),
                CustomForm(
                  darkTheme: false,
                  prefixIcon: null,
                  hintText: "Enter waste unit",
                  controller: wasteUnitTextEditingController,
                  keyboardType: TextInputType.numberWithOptions(),
                ),
                5.l,
                RText(
                    title: "Waste Weight(in kg)",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500)),
                CustomForm(
                  darkTheme: false,
                  prefixIcon: null,
                  hintText: "Enter waste unit",
                  controller: wasteWeightTextEditingController,
                  keyboardType: TextInputType.numberWithOptions(),
                ),
                5.l,
                RText(
                    title: "Upload image",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500)),
                image != null
                    ? SizedBox(
                        height: 200.h,
                        width: 500.h,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.r),
                            child: Image.file(
                              image!,
                              fit: BoxFit.cover,
                            )),
                      )
                    : GestureDetector(
                        onTap: selectImage,
                        child: Container(
                          height: 200.h,
                          width: 500.h,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20.r)),
                          child: Center(
                            child: RText(
                                title: "Upload image",
                                style: TextStyle(
                                    color: Color(0xff49454F),
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),
                      ),
                20.l,
                BlocConsumer<CreateListingBloc, CreateListingState>(
                    listener: (context, state) {
                  if (state is CreateListingSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Waste uploaded successfully ✅"),
                          backgroundColor: Colors.green),
                    );
                    // Navigate to the success page
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SuccessfulListing()));
                  }
                  if (state is CreateListingFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(state.error),
                          backgroundColor: Colors.red),
                    );
                  }
                }, builder: (context, state) {
                  final bool isLoading = state is CreateListingInProgress;
                  return GestureDetector(
                    onTap: isLoading
                        ? null
                        : () {
                            context.read<CreateListingBloc>().add(
                                  SubmitListingRequested(
                                    title:
                                        titleTextEditingController.text.trim(),
                                    description: wasteDescTextEditingController
                                        .text
                                        .trim(),
                                    pickupLocation:
                                        pickupTextEditingController.text.trim(),
                                    type: _wasteTypeFromString(selectedWaste),
                                    unit: double.parse(
                                        wasteUnitTextEditingController.text
                                            .trim()),
                                    weight: double.parse(
                                        wasteWeightTextEditingController.text
                                            .trim()),
                                    contactPhone:
                                        phoneTextEditingController.text.trim(),
                                    image: image!,
                                  ),
                                );
                          },
                    child: Container(
                      height: 60.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Tcolor.PrimaryYellow,
                          borderRadius: BorderRadius.circular(30.r)),
                      child: Center(
                        child: isLoading
                            ? SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : RText(
                                title: "Submit",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                      ),
                    ),
                  );
                }),
                20.l,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
