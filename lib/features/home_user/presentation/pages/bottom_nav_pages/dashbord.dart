import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/space_exs.dart';
import 'package:trash2cash/features/home_user/presentation/pages/widgets/balance_card.dart';
import 'package:trash2cash/features/home_user/presentation/pages/widgets/custom_appbar.dart';
import 'package:trash2cash/features/home_user/presentation/pages/widgets/dashed_line_row.dart';
import 'package:trash2cash/features/home_user/presentation/pages/widgets/view_details.dart';
import 'package:trash2cash/features/home_user/presentation/widgets/create_account_modal.dart';
import 'package:trash2cash/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:trash2cash/features/waste/presentation/bloc/listings_bloc.dart';

import '../../../../../constants/r_text.dart';

class Dashbord extends StatefulWidget {
  const Dashbord({super.key});

  @override
  State<Dashbord> createState() => _DashbordState();
}

class _DashbordState extends State<Dashbord> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkProfileAndShowDialog();
    });
    context.read<ListingsBloc>().add(FetchListingsRequested());
  }

  void _checkProfileAndShowDialog() {
    // Get the current state from the ProfileBloc
    final profileState = context.read<ProfileBloc>().state;

    if (profileState is ProfileLoadSuccess) {
      // Check if the phone number is missing
      if (profileState.profile.phone == null) {
        // If it's missing, show the dialog
        showDialog(
          context: context,
          barrierDismissible: false, // User must interact with the dialog
          builder: (dialogContext) {
            return const AccountSetupDialog();
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: PreferredSize(preferredSize: Size.fromHeight(550.h), child: CustomAppbar()),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
        child: Column(
          children: [
            CustomAppbar(
              name: box.read("firstName") ?? "",
            ),
            20.l,
            BalanceCard(),
            20.l,
            DashedLineRow(
              leftText: "Waste Listing",
            ),
            20.l,
            Expanded(
              child: BlocBuilder<ListingsBloc, ListingsState>(
                  builder: (context, state) {
                if (state is ListingsLoadInProgress) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ListingsLoadSuccess) {
                  // If there are no listings, show a message
                  if (state.listings.isEmpty) {
                    return const Center(
                        child: RText(
                      title: "You haven't listed any waste yet.",
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w500),
                    ));
                  }

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.w,
                      mainAxisSpacing: 30.h,
                      childAspectRatio: 4.5 / 2.5,
                      mainAxisExtent: 250.h,
                    ),
                    itemCount: state.listings.length,
                    itemBuilder: (context, index) {
                      final listing = state.listings[index];
                      return WastListingTile(
                        // IMPORTANT: Use NetworkImage for URLs, not Image.asset
                        imageUrl: listing.imageUrl.toString(),
                        title: listing.title.toString(),
                        type: listing
                            .type.toString(), // Convert enum to string for display
                        weight: "${listing.weight}kg",
                        status: listing.status.toString(),
                      );
                    },
                  );
                }

                if (state is ListingsLoadFailure) {
                  return Center(
                      child: RText(
                    title: "Failed to load listings: ${state.error}",
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400),
                  ));
                }

                return Center(
                    child: RText(
                  title: "Fetching your listings...",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 15.sp),
                ));
              }),
            )
          ],
        ),
      )),
    );
  }
}

class WastListingTile extends StatelessWidget {
  const WastListingTile({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.type,
    required this.weight,
    required this.status
  });

  final String imageUrl;
  final String title;
  final String type;
  final String weight;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20.r)),
      child: Column(
        children: [
          SizedBox(
            height: 120.h,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r)),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                // Add loading and error builders for a better UX
                loadingBuilder: (context, child, progress) {
                  return progress == null
                      ? child
                      : const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image, color: Colors.grey);
                },
              ),
            ),
          ),
          15.l,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 80.w,
                child: RText(
                    title: title,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w900),
                        overflow: TextOverflow.ellipsis,
                        
                        ),
              ),
              Container(
                
                padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 5.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: Tcolor.SecondaryGreenr),
                child: RText(
                    title: status,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                        color: Tcolor.PrimaryGreen,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w900)),
              )
            ],
          ),
          15.l,
          Row(
            children: [
              RText(
                  title: type,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w900)),
              5.b,
              CircleAvatar(
                radius: 2, // dot size
                backgroundColor: Colors.grey, // dot color
              ),
              5.b,
              RText(
                  title: weight ,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w900))
            ],
          ),
          15.l,
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailsPage(
                    imagePath: imageUrl,
                    title: title,
                    type: type,
                    weight: weight,
                    status: status,
                  ),
                ),
              );
            },
            child: Row(
              children: [
                RText(
                    title: "View Details",
                    style: TextStyle(
                        color: Tcolor.tertiaryGreen,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w900)),
                5.b,
                GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.arrow_right_alt_outlined,
                      color: Tcolor.tertiaryGreen,
                      size: 20.sp,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
