import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/custom_form.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';
import 'package:trash2cash/features/home_user/presentation/pages/widgets/successful_widthdrawal.dart';
import 'package:trash2cash/features/home_user/presentation/pages/widgets/withdraw_funds_custom_appbar.dart';
import 'package:trash2cash/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:trash2cash/features/wallet/presentation/bloc/withdrawal/withdrawal_bloc.dart';

class WithdrawFunds extends StatefulWidget {
  const WithdrawFunds({super.key});

  @override
  State<WithdrawFunds> createState() => _WithdrawFundsState();
}

class _WithdrawFundsState extends State<WithdrawFunds> {
  final accountController = TextEditingController();
  final amountController = TextEditingController();
  final bankController = TextEditingController();

  final Map<String, String> bankMap = {
    "Guaranty Trust Bank": "058",
    "United Bank for Africa": "033",
    "Access Bank": "044",
    "First City Monument Bank": "214",
    // Add all other necessary banks here
  };
   String? selectedBankName;

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
  void dispose() {
    accountController.dispose();
    amountController.dispose();
    bankController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(90.h),
            child: WithdrawFundsCustomAppbar()),
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
                        controller: amountController,
                        hintText: "Enter the amount to withdraw",
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Please enter an amount';
                          if (double.tryParse(value) == null) return 'Please enter a valid number';
                          return null;
                        }, darkTheme: false,
                      ),
              5.l,
              5.l,
              RText(
                  title: "Bank",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500)),
              CustomForm(
                darkTheme: false,
                        controller: bankController,
                        hintText: "Select bank account",
                        readOnly: true,
                        validator: (value) => selectedBankName == null ? 'Please select a bank' : null,
                        suffixIcon: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedBankName,
                            icon: const Icon(Icons.arrow_drop_down_outlined, color: Colors.black),
                            items: bankMap.keys.map((String bankName) {
                              return DropdownMenuItem<String>(
                                value: bankName,
                                child: Text(bankName),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                selectedBankName = newValue;
                                bankController.text = newValue ?? "";
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
                        controller: accountController,
                        hintText: "Enter account number",
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Please enter an account number';
                          if (value.length != 10) return 'Account number must be 10 digits';
                          return null;
                        },
                      ),
              20.l,
              BlocConsumer<WithdrawalBloc, WithdrawalState>(
                listener: (context, state) {
                  if (state is WithdrawalSuccess) {
                    // On success, tell the main WalletBloc to refresh its data
                    context.read<WalletBloc>().add(FetchWalletDetails());

                    // Then, navigate to the success screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SuccessfulWidthdrawal()),
                    );
                  }

                  if (state is WithdrawalFailure) {
                    // On failure, show an error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(state.error),
                          backgroundColor: Colors.red),
                    );
                  }
                },
                builder: (context, state) {
                  final bool isLoading = state is WithdrawalInProgress;
                 return  GestureDetector(
                        onTap: isLoading ? null : () {
                          // 1. Validate the form first
                          
                            // 2. Safely parse the amount
                            final double? withdrawalAmount = double.tryParse(amountController.text.trim());
                            if (withdrawalAmount == null) return;
                            
                            // 3. Get the bank code from the map using the selected name
                            final String? bankCode = bankMap[selectedBankName];
                            if (bankCode == null) return;

                            // 4. Dispatch the event to the BLoC
                            context.read<WithdrawalBloc>().add(
                              WithdrawalRequested(
                                amount: withdrawalAmount,
                                bankCode: bankCode,
                                accountNumber: accountController.text.trim(),
                              ),
                            );
                          
                        },
                        child: Container(
                          height: 60.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Tcolor.PrimaryGreen,
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Center(
                            child: isLoading
                                ? const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
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
                      );


                },
              ),
              
            ],
          ),
        )),
      ),
    );
  }
}
