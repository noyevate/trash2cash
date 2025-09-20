import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';
import 'package:trash2cash/features/waste/domain/entities/recycler_waste_listing.dart';
import 'package:trash2cash/features/waste/presentation/widgets/info_card.dart';
import 'package:trash2cash/features/waste/presentation/widgets/seller_card.dart';
// Import your helper widgets and theme colors

class ProductDetailsPage extends StatelessWidget {
  final RecyclerWasteListing listing;
  
  const ProductDetailsPage({super.key, required this.listing});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.h),
          child: Container(
            decoration: BoxDecoration(color:Colors.white),
            child: SafeArea(
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
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
                    ],)
                 ] ),
              ),
          ),
      ),
      body: Stack(
        children: [
          // --- Scrolling Content ---
          CustomScrollView(
            slivers: [
              // --- Sliver App Bar ---
              SliverAppBar(
                expandedHeight: 250.h,
                pinned: true,
                backgroundColor: Colors.white,
                elevation: 1,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    listing.imageUrl ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.image, size: 100, color: Colors.grey),
                  ),
                ),
              ),

              // --- Main Content Area ---
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // --- Header Card ---
                    _buildHeaderCard(listing),
                    const SizedBox(height: 16),

                    // --- Description Card ---
                    InfoCard(
                      title: "Description",
                      content: Text(
                        listing.description ?? "No description available.",
                        style: const TextStyle(color: Colors.black54, height: 1.5),
                      ),
                    ),

                    // --- Additional Info Card ---
                    InfoCard(
                      title: "Additional information",
                      content: Column(
                        children: [
                          _buildInfoRow("Posted", "2 hrs ago"), // You'd format listing.time
                          _buildInfoRow("Available Pickup Times", "Mon - Fri, 9AM - 6PM"),
                        ],
                      ),
                    ),
                    
                    // --- Seller Info Card ---
                    const SellerInfoCard(),
                    
                    // Add padding at the bottom to ensure content isn't hidden by the buy button
                    const SizedBox(height: 100), 
                  ]),
                ),
              ),
            ],
          ),

          // --- Sticky Buy Now Button ---
          _buildStickyBuyButton(listing),
        ],
      ),
    );
  }

  // --- Helper Widgets for the Build Method ---

  Widget _buildHeaderCard(RecyclerWasteListing listing) {
    return Card(
      elevation: 0,
      color: Colors.grey[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listing.title ?? 'Untitled Listing',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text("Category: ${listing.type ?? 'N/A'}", style: const TextStyle(color: Colors.grey)),
                  Text("${listing.unit?.toStringAsFixed(0) ?? '0'}unit (${listing.weight?.toStringAsFixed(1) ?? '0'}kg)", style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.lightGreen,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Text(
                    listing.status ?? 'Available',
                    style: TextStyle(color: Tcolor.PrimaryGreen, fontWeight: FontWeight.bold),
                  ),
                  8.b,
                   CircleAvatar(radius: 4, backgroundColor: Tcolor.PrimaryGreen),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildStickyBuyButton(RecyclerWasteListing listing) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, spreadRadius: 5),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "₦${listing.amount?.toStringAsFixed(0) ?? '0'}",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Tcolor.PrimaryGreen,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text("Buy Now", style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}