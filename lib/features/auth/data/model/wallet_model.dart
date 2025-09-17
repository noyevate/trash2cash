

import 'package:trash2cash/features/Auth/domain/entities/wallet.dart';

class WalletModel extends Wallet {
  const WalletModel({required super.balance, required super.points});

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      balance: (json['balance'] as num).toDouble(),
      points: json['points'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {'balance': balance, 'points': points};
  }
}