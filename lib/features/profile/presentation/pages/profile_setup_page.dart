import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/custom_form.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';
import 'package:trash2cash/constants/utils.dart';
import 'package:trash2cash/features/home_user/presentation/pages/home.dart';
import 'package:trash2cash/features/profile/presentation/bloc/location/location_bloc.dart';
import 'package:trash2cash/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:trash2cash/features/profile/presentation/widgets/profile_app_bar.dart';

class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  final TextEditingController fullName = TextEditingController();
  final TextEditingController contactNumber = TextEditingController();
  final TextEditingController location =  TextEditingController();
  final TextEditingController pickupLocation = TextEditingController();
  File? image;
  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Pre-fill the form with existing data if available
    final state = context.read<ProfileBloc>().state;
    if (state is ProfileLoadSuccess) {
      fullName.text = state.profile.firstName;
      contactNumber.text = state.profile.phone ?? '';
    }
  }

  @override
  void dispose() {
    fullName.dispose();
    contactNumber.dispose();
    location.dispose();
    pickupLocation.dispose();
    super.dispose();
  }

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000), // The earliest date a user can select
      lastDate: DateTime(2101), // The latest date a user can select
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Method to show the time picker
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      image != null
                          ? Center(
                              child: SizedBox(
                                height: 150.h,
                                width: 150.w,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 75.h,
                                      backgroundColor: Colors.grey.shade200,
                                    ),
                                    CircleAvatar(
                                      // padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
                                      radius: 70.h,
                                      backgroundImage: FileImage(image!),
                                    ),
                                    Positioned(
                                      bottom: 5.h,
                                      right: 10
                                          .w, // Changed to 'right' for a more common placement, but you can use 'left'
                                      child: Image.asset(
                                        "images/Camera.png",
                                        height: 35.h,
                                        width: 35.w,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          :
                          // The part when image is null
                          Center(
                              child: GestureDetector(
                                onTap:
                                    selectImage, // Your existing function to pick an image
                                child: Container(
                                  height: 150.h,
                                  width: 150.w,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 5.h,
                                        right: 10
                                            .w, // Changed to 'right' for a more common placement, but you can use 'left'
                                        child: Image.asset(
                                          "images/Camera.png",
                                          height: 35.h,
                                          width: 35.w,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      20.l,
                      RText(
                          title: "Personal Information",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20.sp)),
                      15.l,
                      RText(
                          title: "Full Name",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500)),
                      5.l,
                      CustomForm(
                        darkTheme: false,
                        prefixIcon: null,
                        hintText: "Enter Full Name",
                        controller: fullName,
                      ),
                      8.l,
                      RText(
                          title: "Contact Number",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500)),
                      5.l,
                      CustomForm(
                        darkTheme: false,
                        prefixIcon: null,
                        hintText: "Enter Contact Number",
                        controller: contactNumber,
                      ),
                      8.l,
                      RText(
                          title: "Location",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500)),
                      5.l,
                      CustomForm(
                        darkTheme: false,
                        prefixIcon: null,
                        hintText: "Enter your location",
                        controller: location,
                      ),
                      8.l,
                      
                      10.l,
                      20.l,
                      BlocConsumer<ProfileBloc, ProfileState>(
                        listener: (context, state) {
                           if (state is ProfileLoadSuccess) {
                 Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Home()));
                }
                
                if(state is ProfileLoadFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("an error occured"),
                        backgroundColor: Colors.red,
                      ),
                    );
                }
                        },
                        builder: (contxt, state) {
                          final bool isLoading = state is ProfileUpdateInProgress;
                          return GestureDetector(
                            onTap: isLoading
                                ? () {print("isLoading");}
                                : () {
                                  print("submit");
                                    context
                                        .read<ProfileBloc>()
                                        .add(UpdateProfileRequested(
                                          firstName: fullName.text.trim(),
                                          location: location.text.trim(),
                                          phone: contactNumber.text.trim(),
                                          image:
                                              image, // The File? from your page state
                                        ));
                                  },
                            child: Container(
                              height: 60.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Tcolor.PrimaryGreen,
                                  borderRadius: BorderRadius.circular(30.r)),
                              child: Center(
                                child: isLoading
                                    ? SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : RText(
                                        title: "Submit",
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                              ),
                            ),
                          );
                        },
                      ),

                      20.l,
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Add this helper method inside your _ProfileSetupPageState class
Widget _buildPickerBox({
  required String label,
  required String hintText,
  required String valueText,
  required bool hasValue,
  required VoidCallback onTap,
}) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // The label above the box
        RText(
          title: label,
          style: TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500),
        ),
        5.l,
        // The tappable box
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 60.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              // border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // The hint text or the selected value
                Text(
                  hasValue ? valueText : hintText,
                  style: TextStyle(
                    fontSize: 15.sp,
                    // Use grey for hint text and black for the actual value
                    color: hasValue ? Colors.black : Colors.grey.shade600,
                  ),
                ),
                // The dropdown icon
                Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade600),
              ],
            ),
          ),
        ),
      ],
    ),
  );
  // String? _currentAddress;
}
