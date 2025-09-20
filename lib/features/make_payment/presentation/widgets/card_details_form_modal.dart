import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/features/make_payment/presentation/bloc/payment_bloc.dart';
import 'package:trash2cash/features/make_payment/presentation/pages/payment_successful.dart';
import 'package:trash2cash/features/waste/domain/entities/recycler_waste_listing.dart';
// Import your custom widgets and theme colors

class CardDetailsFormModal extends StatefulWidget {
  // We pass the listing to the modal so it knows the amount, ID, etc.
  final RecyclerWasteListing listing;

  const CardDetailsFormModal({super.key, required this.listing});

  @override
  State<CardDetailsFormModal> createState() => _CardDetailsFormModalState();
}

class _CardDetailsFormModalState extends State<CardDetailsFormModal> {
  final _formKey = GlobalKey<FormState>();
  final cardNumberController = TextEditingController();
  final expiryDateController = TextEditingController();
  final cvvController = TextEditingController();

  @override
  void dispose() {
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Padding that respects the device's keyboard
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 24,
        right: 24,
        top: 24,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            // Makes the bottom sheet only as tall as its content
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Card Details",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
          
              // --- Card Number Field ---
              TextFormField(
                controller: cardNumberController,
                decoration: _buildInputDecoration(
                    hintText: "Card Number (1234 5678 9012 3456)"),
                keyboardType: TextInputType.number,
                // Add validator if needed
              ),
              const SizedBox(height: 16),
          
              // --- Expiry and CVV Row ---
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: expiryDateController,
                      decoration:
                          _buildInputDecoration(hintText: "Expiry Date (MM/YY)"),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: cvvController,
                      decoration: _buildInputDecoration(hintText: "CVV"),
                      keyboardType: TextInputType.number,
                      obscureText: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
          
              // --- Make Payment Button ---
              BlocConsumer<PaymentBloc, PaymentState>(
                listener: (context, state) {
                  if (state is PaymentSuccess) {
                    // Close the modal first
                    Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => PaymentSuccessful(listing: widget.listing,)),
                            );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Listing accepted successfully!"),
                          backgroundColor: Colors.green),
          
                          
                    );
                  }
                  if (state is PaymentFailure) {
                    // Show error message, but keep the modal open
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(state.error),
                          backgroundColor: Colors.red),
                    );
                  }
                },
                builder: (context, state) {
                  final bool isLoading = state is PaymentInProgress;
          
                  return Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  // Dispatch the event with the listing ID
                                  context.read<PaymentBloc>().add(
                                        AcceptListingRequested(
                                            widget.listing.id!),
                                      );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Tcolor.PrimaryGreen,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                      color: Colors.white))
                              : const Text("Make payment",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                        ),
                      ),
          
                      const SizedBox(height: 12),
          
                      // --- Cancel Payment Button ---
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () =>
                              Navigator.of(context).pop(), // Just close the modal
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Tcolor.PrimaryGreen,
                            side: BorderSide(color: Tcolor.PrimaryGreen),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          child: const Text("Cancel Payment",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  );
                },
              ),
          
              const SizedBox(height: 12),
          
              
          
              // --- Security Text ---
              const Center(
                child: Text(
                  "Your card details are encrypted and secured by Paystack.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to keep InputDecoration consistent
  InputDecoration _buildInputDecoration({required String hintText}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
          color: Color(0xff49454F), fontSize: 15.sp, fontFamily: "Metropolis"),
      filled: true,
      fillColor: Colors.grey.shade200,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    );
  }
}
