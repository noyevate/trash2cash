import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trash2cash/features/choose_role/domain/entities/user_role.dart';
import 'package:trash2cash/features/home_user/presentation/pages/home.dart';
import 'package:trash2cash/features/profile/presentation/bloc/profile_bloc.dart';
// Import your dashboard pages
// import 'package:your_app/features/dashboard/presentation/pages/generator_dashboard.dart';
// import 'package:your_app/features/dashboard/presentation/pages/recycler_dashboard.dart';

class GateKeeper extends StatefulWidget {
  const GateKeeper({super.key});

  @override
  State<GateKeeper> createState() => _GateKeeperState();
}

class _GateKeeperState extends State<GateKeeper> {
  @override
  void initState() {
    super.initState();
    // Trigger the profile fetch as soon as this page loads
    context.read<ProfileBloc>().add(GetProfileRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          // The listener handles the navigation side-effect
          if (state is ProfileLoadSuccess) {
            if (state.profile.role == UserRole.GENERATOR) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => Home()));
              print("NAVIGATING TO GENERATOR DASHBOARD");
            } else if(state.profile.role == UserRole.RECYCLER) {
              print("Recycler_age");
              // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => RecyclerDashboard()));
              print("NAVIGATING TO RECYCLER DASHBOARD");
            } else if(state.profile.role == null) {
              print("NAVIGATING TO ChOOSE ROLE");
            }
          }
        },
        builder: (context, state) {
          // The builder handles what the user sees on THIS page
          if (state is ProfileLoadFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Failed to load your profile.'),
                  Text(state.error),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ProfileBloc>().add(GetProfileRequested());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          // While loading or in initial state, show a spinner
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}