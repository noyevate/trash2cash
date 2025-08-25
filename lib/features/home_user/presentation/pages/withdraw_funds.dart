import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/custom_form.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';
import 'package:trash2cash/features/home_user/presentation/pages/widgets/successful_widthdrawal.dart';
import 'package:trash2cash/features/home_user/presentation/pages/widgets/withdraw_funds_custom_appbar.dart';

class WithdrawFunds extends StatefulWidget {
  const WithdrawFunds({super.key});

  @override
  State<WithdrawFunds> createState() => _WithdrawFundsState();
}

class _WithdrawFundsState extends State<WithdrawFunds> {
  final account =  TextEditingController();
  final amounnt = TextEditingController();
  final bank = TextEditingController();

  final List<String> banks = ["GTB", "UBA", "ACCESS", "FCMB"];
  String? selectedBank;

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
          builder: (context) => SuccessfulWidthdrawal(),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: PreferredSize(preferredSize: Size.fromHeight(90.h), child: WithdrawFundsCustomAppbar()),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.l,
                RText(
                        title: "Amount",
                        style: TextStyle(color: Colors.black, fontSize: 15.sp)),
                    CustomForm(
                      darkTheme: false,
                      prefixIcon: null,
                      hintText: "Enter the amount to withdraw",
                      controller: amounnt,
                      
                    ),


                    5.l,

                    5.l,
                RText(
                    title: "Bank",
                    style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500)),
                    CustomForm(
                darkTheme: false,
                prefixIcon: null,
                hintText: "Select bank account",
                controller: bank,
                readOnly: true, // prevent typing
                suffixIcon: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    dropdownColor: Colors.white,
                    value: selectedBank,
                    icon: const Icon(Icons.arrow_drop_down_outlined, color: Colors.black),
                    items: banks.map((String value) {
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
                        selectedBank = newValue;
                        bank.text = newValue ?? "";
                      });
                    },
                  ),
                ),
              ),
              10.l,

              RText(
                        title: "Account number",
                        style: TextStyle(color: Colors.black, fontSize: 15.sp)),
                    CustomForm(
                      darkTheme: false,
                      prefixIcon: null,
                      hintText: "Enter account number",
                      controller: account,
                      
                    ),


                    20.l,



                    GestureDetector(
      onTap: _isLoading ? null : _handleTap,
      child: Container(
        height: 60.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Tcolor.PrimaryGreen,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Center(
          child: _isLoading
              ? SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : RText(
                  title: "Withdraw Funds",
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
        ),
      ),
    )

              ],
            ),
          )
        ),
      ),
    );
  }
}