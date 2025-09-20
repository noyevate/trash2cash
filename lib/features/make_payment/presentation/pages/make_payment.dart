import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/format_money.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';
import 'package:trash2cash/features/make_payment/presentation/pages/payment_successful.dart';
import 'package:trash2cash/features/make_payment/presentation/widgets/card_details_form_modal.dart';
import 'package:trash2cash/features/waste/domain/entities/recycler_waste_listing.dart';

class MakePayment extends StatefulWidget {
  const MakePayment({super.key, required this.listing});
  final RecyclerWasteListing listing;

  @override
  State<MakePayment> createState() => _MakePaymentState();
}

class _MakePaymentState extends State<MakePayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.h),
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Ionicons.arrow_back_circle_outline),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 15.w,
                                right: 15.w,
                              ),
                              child: RText(
                                title: "Product Details",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        )
                      ]),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w),
          child:
              SingleChildScrollView(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Container(
                padding: EdgeInsets.all(10.w), // Padding on the parent
                decoration: BoxDecoration(
                  color: Tcolor.CustomNarBar,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Row(
                  // Align children to the top of the row
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- 1. The Image (with a fixed width) ---
                    SizedBox(
                      height: 150.h,
                      width: 130.w, // Give the image a specific, fixed width
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: (widget.listing.imageUrl != null &&
                                widget.listing.imageUrl!.isNotEmpty)
                            ? Image.network(
                                widget.listing.imageUrl!,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, progress) =>
                                    progress == null
                                        ? child
                                        : const Center(
                                            child: CircularProgressIndicator()),
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image,
                                        color: Colors.grey, size: 40),
                              )
                            : Container(
                                color: Colors.grey[200],
                                child: const Icon(Icons.image_not_supported,
                                    color: Colors.grey, size: 40),
                              ),
                      ),
                    ),
                
                    const SizedBox(width: 12), // Spacing between image and text
                
                    // --- 2. The Content (wrapped in Expanded) ---
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.listing.title ?? "Untitled Listing",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                fontFamily: "Metropolis"),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          8.l,
                          RText(
                            title: "${widget.listing.type ?? 'N/A'}",
                            style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                          ),
                          const SizedBox(height: 4),
                          RText(
                            title:
                                "${formatMoney(widget.listing.unit)}unit ${widget.listing.weight?.toStringAsFixed(1) ?? '0'}kg",
                            style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 12.sp,
                                color: Tcolor.PrimaryGreen,
                              ),
                              RText(
                                title: "Ikeja, Lagos",
                                style: TextStyle(
                                    color: Tcolor.PrimaryGreen, fontSize: 13.sp),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              color: Tcolor.SecondaryGreenr,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                RText(
                                  title: widget.listing.status.toString(),
                                  style: TextStyle(
                                    color: Tcolor.PrimaryGreen,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500,
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
                          Text(
                            "₦${formatMoney(widget.listing.amount)}",
                            style: TextStyle(
                                color: Tcolor.MoneyColor,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                            ),
                            20.l,
                            RText(
                title: "Payment Method",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold),
                            ),
                            20.l,
                            PaymentType(
                text: 'Debit Card',
                onTap: () {
                  // --- THIS IS THE KEY FUNCTION CALL ---
                  showModalBottomSheet(
                    context: context,
                    // This makes the modal sheet scrollable when the keyboard appears
                    isScrollControlled: true,
                    // Makes the corners rounded to match the design
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (context) {
                      // We return the new form widget we just created
                      return CardDetailsFormModal(listing: widget.listing);
                    },
                  );
                },
                tap: false,
                            ),
                            12.l,
                            PaymentType(
                text: 'Bank Transfer',
                onTap: () {},
                tap: true,
                            ),
                            12.l,
                            PaymentType(
                text: 'Wallet Balance',
                onTap: () {},
                tap: true,
                            )
                          ]),
              ),
        ));
  }
}

class PaymentType extends StatelessWidget {
  const PaymentType({
    super.key,
    required this.text,
    this.onTap,
    required this.tap,
  });

  final String text;
  final void Function()? onTap;
  final bool tap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.h,
        width: double.infinity,
        padding: EdgeInsets.only(left: 10.w, right: 10.w),
        decoration: BoxDecoration(
            color: Tcolor.CustomNarBar,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Tcolor.ActivityBorder)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RText(
                title: text,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500),
              ),
              CircleAvatar(
                radius: 7.r,
                backgroundColor: Tcolor.ActivityBorder,
              )
            ],
          ),
        ),
      ),
    );
  }
}




// Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 // The listing object comes from your BLoC's state in the parent widget
//                                 builder: (_) => PaymentSuccessful(listing: widget.listing,
//                                   ),
//                               ),
//                             );