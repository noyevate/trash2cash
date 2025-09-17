// You can create a new file for this, e.g., lib/features/profile/presentation/widgets/profile_loading_dialog.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/features/choose_role/domain/entities/user_role.dart';
import 'package:trash2cash/features/choose_role/presentation/pages/choose_role.dart';
import 'package:trash2cash/features/home_user/presentation/pages/home.dart';
import 'package:trash2cash/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:trash2cash/features/recycler_home/presentation/pages/recycler_home.dart';


// Import your destination pages
// import 'package:your_app/features/dashboard/presentation/pages/home.dart'; // Generator Home
// import 'package:your_app/features/dashboard/presentation/pages/recycler_dashboard.dart';

class ProfileLoadingDialog extends StatefulWidget {
  const ProfileLoadingDialog({super.key});

  @override
  State<ProfileLoadingDialog> createState() => _ProfileLoadingDialogState();
}

class _ProfileLoadingDialogState extends State<ProfileLoadingDialog> {
  @override
  void initState() {
    super.initState();
    // Trigger the profile fetch as soon as the dialog is built
    context.read<ProfileBloc>().add(GetProfileRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      // Prevent the user from dismissing the dialog by tapping outside
      // barrierDismissible: false,
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          // The listener handles navigation. We use pushAndRemoveUntil
          // to clear the auth stack (Login/Register pages) behind the new page.
          if (state is ProfileLoadSuccess) {

            print("start");
            if (state.profile.role == null) {
          
              print("User has no role, navigating to ChooseRolePage");
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const ChooseRole()),
                (route) => false,
              );
            } else if (state.profile.role == UserRole.GENERATOR) {
              print("NAVIGATING TO GENERATOR DASHBOARD");
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const Home()),
                (route) => false,
              );
            } else { // RECYCLER
              print("NAVIGATING TO RECYCLER DASHBOARD");
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const RecyclerHome()),
                (route) => false,
              );
            }
          }
        },
        builder: (context, state) {
          // The builder defines what the user sees INSIDE the modal
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r)
            ),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (state is ProfileLoadFailure) ...[
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                   RText(
                    title: 'Failed to load your profile.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(state.error, textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ProfileBloc>().add(GetProfileRequested());
                    },
                    child: RText(title: 'Retry', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),),
                  ),
                ] else ...[
                  // While loading or initial, show a spinner and text
                  const CircularProgressIndicator(),
                  const SizedBox(height: 20),
                   RText(
                    title: "Getting your account ready...",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}