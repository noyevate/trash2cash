import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';
import 'package:trash2cash/constants/format_money.dart';
import 'package:trash2cash/features/home_user/presentation/pages/withdraw_funds.dart';
import 'package:trash2cash/features/wallet/presentation/bloc/wallet_bloc.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();

    final walletBal = box.read("walletBalance");
    final points = box.read("points");
    return BlocBuilder<WalletBloc, WalletState>(builder: (context, state) {
      String balanceText = "₦--.--";
      String pointsText = "-- pts";
      Widget mainBalanceWidget;
      Widget pointsWidget;

      if (state is WalletLoadSuccess) {
        // --- SUCCESS STATE ---
        balanceText =
            "₦${formatMoney(state.wallet.balance)}"; // Assuming formatMoney is a helper you have
        pointsText = "${state.wallet.points} pts";

        mainBalanceWidget = Text(
          balanceText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        );
        pointsWidget = Text(
          pointsText,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        );
      } else if (state is WalletLoadInProgress || state is WalletInitial) {
        // --- LOADING STATE ---
        mainBalanceWidget = _buildLoadingPlaceholder(width: 120, height: 28);
        pointsWidget = _buildLoadingPlaceholder(width: 70, height: 16);
      } else {
        // This will catch WalletLoadFailure
        // --- FAILURE STATE ---
        mainBalanceWidget = const Text(
          "Unavailable",
          style: TextStyle(
              color: Colors.white70, fontSize: 20, fontWeight: FontWeight.bold),
        );
        pointsWidget = const Text(
          "Error",
          style: TextStyle(color: Colors.white70, fontSize: 14),
        );
      }

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Tcolor.PrimaryGreen,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RText(
                  title: "Your Balance",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
                // Text(
                //   walletBal != null ? "₦${formatMoney(walletBal)}" : "₦0.0",
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 24.sp,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),

                mainBalanceWidget = Text(
                  balanceText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
              ],
            ),
            30.l,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               
                pointsWidget = Text(
                  pointsText,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                ElevatedButton(
                  onPressed: state is WalletLoadSuccess
                      ? () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const WithdrawFunds()));
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Tcolor.PrimaryYellow,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  ),
                  child: RText(
                    title: "Withdraw",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                        color: Tcolor.PrimaryGreen),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}

// Helper widget for a simple loading placeholder (shimmer effect)
Widget _buildLoadingPlaceholder(
    {required double width, required double height}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.2),
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
