import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ionicons/ionicons.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';
import 'package:trash2cash/features/choose_role/domain/entities/user_role.dart';
import 'package:trash2cash/features/choose_role/presentation/bloc/user_role_bloc.dart';
import 'package:trash2cash/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:trash2cash/features/profile/presentation/widgets/profile_loading_dialog.dart';

class ChooseRole extends StatefulWidget {
  const ChooseRole({super.key});

  @override
  State<ChooseRole> createState() => _ChooseRoleState();
}

class _ChooseRoleState extends State<ChooseRole> {
   UserRole? _selectedRole;
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: BlocConsumer<UserRoleBloc, UserRoleState>(
            listener: (context, state) {
              if (state is UserRoleUpdateSuccess) {
                 showDialog(
          context: context,
          // barrierDismissible: false, // User cannot dismiss it
          builder: (dialogContext) {
            // It's crucial to provide the ProfileBloc to the dialog's context.
            // context.read<ProfileBloc>() finds the BLoC provided in main.dart
            return BlocProvider.value(
              value: context.read<ProfileBloc>(),
              child: const ProfileLoadingDialog(),
            );
          },
        );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Role set to ${state.selectedRole.name}!'), backgroundColor: Colors.green),
            );
            // TODO: Navigate to the main dashboard/home page
            // Navigator.of(context).pushReplacement(...);
          }
          if (state is UserRoleUpdateFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
            },
            builder: (context, state) {
              final bool isLoading = state is UserRoleUpdateInProgress;
             return Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Column(
          children: [
            10.l,
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Ionicons.arrow_back_circle_outline),
                ),
                20.b,
                Column(
                  children: [
                    RText(
                        title: "Let’s Set Up",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 35.sp,
                            fontWeight: FontWeight.bold)),
                    RText(
                        title: "Your Account",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 35.sp,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            20.l,
            RText(
                title: "Choose how you want to use the app.",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400)),
            RText(
                title: "This helps us tailor your dashboard and",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400)),
            RText(
                title: "features to match your needs.",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400)),
            10.l,
            if (isLoading) ...[
                    const SizedBox(height: 20),
                    const CircularProgressIndicator(),
                    const SizedBox(height: 20),
                  ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: isLoading ? null : () {
                            setState(() { _selectedRole = UserRole.GENERATOR; });
                            context.read<UserRoleBloc>().add(const UserRoleSelected(UserRole.GENERATOR));
                          },
                    borderRadius: BorderRadius.circular(10.r),
                    child: Opacity(
                      opacity: isLoading && _selectedRole != UserRole.GENERATOR ? 0.5 : 1.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset("images/sell_waste.png"),
                          5.l,
                          RText(
                              title: "I sell Waste",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: InkWell(
                    onTap: isLoading ? null : () {
                            setState(() { _selectedRole = UserRole.RECYCLER; });
                            context.read<UserRoleBloc>().add(const UserRoleSelected(UserRole.RECYCLER));
                          },
                    borderRadius: BorderRadius.circular(10.r),
                    child: Opacity(
                      opacity: isLoading && _selectedRole != UserRole.RECYCLER ? 0.5 : 1.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset("images/buy_waste.png"),
                          5.l,
                          RText(
                              title: "I Buy Waste",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
            },
          )
      ),
    );
  }
}
