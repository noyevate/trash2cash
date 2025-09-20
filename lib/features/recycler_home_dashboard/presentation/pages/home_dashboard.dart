import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ionicons/ionicons.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/custom_search.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';
import 'package:trash2cash/features/home_user/presentation/pages/widgets/view_details.dart';
import 'package:trash2cash/features/make_payment/presentation/pages/make_payment.dart';
import 'package:trash2cash/features/notification/presentation/bloc/notification_badge_bloc.dart';
import 'package:trash2cash/features/recycler_home_dashboard/presentation/widgets/custom_appbar.dart';
import 'package:trash2cash/features/waste/presentation/bloc/listings_bloc.dart';
import 'package:trash2cash/features/waste/presentation/bloc/recycler_listings_bloc.dart';
import 'package:trash2cash/features/waste/presentation/pages/product_details_page.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  @override
  void initState() {
    super.initState();
    // As soon as the page is created, dispatch the event to fetch the listings.
    context.read<RecyclerListingsBloc>().add(FetchAllListingsRequested());
    context.read<NotificationBadgeBloc>().add(FetchUnreadCount());
  }

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(190.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            child: Column(
              children: [
                5.l,
                CustomAppbar(
                  name: box.read("firstName") ?? "",
                ),
                15.l,
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Tcolor.tertiaryGreen,
                      size: 20.sp,
                    ),
                    5.b,
                    RText(
                      title: 'Ikeja Lagos',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                10.l,
                Row(
                  children: [
                    Expanded(
                      child: CustomSearch(
                        hintText: "search for waste or location",
                        suffixIcon: Icon(Ionicons.search),
                      ),
                    ),
                    10.b,
                    InkWell(
                        borderRadius: BorderRadius.circular(30.r),
                        onTap: () {},
                        child: Image.asset("images/search_edits.png", height: 50.h, width: 50.h,))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 15.w, right: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RText(
              title: 'Nearby Waste Listings',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500),
            ),
            RText(
              title: 'See waste products within 5 km of Ikeja.',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400),
            ),
            20.l,
            Expanded(
                child: BlocBuilder<RecyclerListingsBloc, RecyclerListingsState>(
              builder: (context, state) {
                if (state is RecyclerListingsInProgress ||
                    state is RecyclerListingsInitial) {
                  return const Center(child: CircularProgressIndicator());
                }
      
                if (state is RecyclerListingsLoadFailure) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RText(
                          title: 'Failed to load listings: ${state.error}',
                          style: TextStyle(
                              color: Tcolor.ActivityBorder, fontSize: 15.sp),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context
                                .read<RecyclerListingsBloc>()
                                .add(FetchAllListingsRequested());
                          },
                          child: RText(
                            title: 'Retry',
                            style: TextStyle(
                                color: Tcolor.ActivityBorder, fontSize: 15.sp),
                          ),
                        ),
                      ],
                    ),
                  );
                }
      
                if (state is RecyclerListingsLoadSuccess) {
                  if (state.listings.isEmpty) {
                    return Center(
                        child: RText(
                            title: "No waste listings are available right now.",
                            style: TextStyle(
                                color: Tcolor.ActivityBorder,
                                fontSize: 15.sp)));
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
                          imageUrl: listing.imageUrl,
                          price: listing.amount,
                          title: listing.title,
                          type: listing.type,
                          weight: listing.weight.toString(),
                          unit: listing.unit.toString(),
                          status: listing.status,
                          onTap1: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                // The listing object comes from your BLoC's state in the parent widget
                                builder: (_) => ProductDetailsPage(
                                    listing: listing),
                              ),
                            );
                          },
                          onTap2: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                // The listing object comes from your BLoC's state in the parent widget
                                builder: (_) => MakePayment(
                                    listing: listing),
                              ),
                            );
                          },
                        );
                      });
                }
                
                return const SizedBox.shrink();
              },
            ))
          ],
        ),
      ),
    );
  }
}

class WastListingTile extends StatelessWidget {
  const WastListingTile(
      {super.key,
      this.imageUrl,
      this.title,
      this.type,
      this.weight,
      this.unit,
      this.price,
      this.status,
      this.onTap1,
      this.onTap2});

  final String? imageUrl;
  final String? title;
  final String? type;
  final String? weight;
  final String? unit;
  final double? price;
  final String? status;
  final void Function()? onTap1;
  final void Function()? onTap2;

  @override
  Widget build(BuildContext context) {
    final displayTitle = title ?? "Untitled Listing";
    final displayType = type ?? "Unknown";
    final displayUnit = unit ?? "0";
    final displayWeight = weight ?? "0";
    final displayStatus = status ?? "Unknown";
    final displayPrice = price ?? 0.0;
    return Container(
      padding: EdgeInsets.all(10.w), // Simplified padding
      decoration: BoxDecoration(
        color: Tcolor.RecyclerGreyCard,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align everything to the start
        children: [
          // --- IMAGE (No changes needed here) ---
          SizedBox(
            height: 110.h,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              // --- Gracefully handle a null imageUrl ---
              child: (imageUrl != null && imageUrl!.isNotEmpty)
                  ? Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) => progress ==
                              null
                          ? child
                          : const Center(child: CircularProgressIndicator()),
                      errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                          size: 40),
                    )
                  : Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.image_not_supported,
                          color: Colors.grey, size: 40),
                    ),
            ),
          ),

          const Spacer(), // Use Spacer for flexible spacing

          // --- MIDDLE SECTION (TITLE & PRICE) ---
          Row(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align items to the top
            children: [
              // --- 1. EXPANDED LEFT COLUMN (TITLE, TYPE, ETC.) ---
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayTitle,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines:
                          1, // Prevent long titles from wrapping and overflowing
                      overflow: TextOverflow.ellipsis, // Show '...' if too long
                    ),
                    Text(
                      displayType,
                      style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 50.w,
                          child: RText(
                            title: "${unit}unit (${weight}kg)",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 12.sp),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 10.sp,
                          color: Tcolor.PrimaryGreen,
                        ),
                        RText(
                          title: "Area",
                          style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(width: 8.w),

              // --- 2. RIGHT COLUMN (STATUS & PRICE) ---
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: Tcolor.SecondaryGreenr,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          displayStatus,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        CircleAvatar(
                          radius: 3,
                          backgroundColor: Tcolor.PrimaryGreen,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "₦${displayPrice.toStringAsFixed(0)}", // Format price cleanly
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),

          const Spacer(),

          // --- BOTTOM BUTTONS ---
          Row(
            children: [
              Expanded(
                  child: InkWell(
                onTap: onTap1,
                child: Container(
                  height: 40.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.r),
                      border: Border.all(color: Tcolor.PrimaryGreen)),
                  child: Center(
                    child: RText(
                        title: "View Details",
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: Tcolor.PrimaryGreen,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              )),
              SizedBox(width: 8.w),
              Expanded(
                  child: InkWell(
                onTap: onTap2,
                child: Container(
                  height: 40.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.r),
                      color: Tcolor.PrimaryGreen),
                  child: Center(
                    child: RText(
                        title: "Buy Now",
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              )),
            ],
          ),

          // 20.l
        ],
      ),
    );
  }
}
