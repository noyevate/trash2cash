import '../../domain/entities/wallet.dart';

class WalletModel extends Wallet {
  const WalletModel({
    required super.id,
    required super.balance,
    required super.points,
    required super.updatedAt,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      id: json['id'] as int,
      balance: (json['balance'] as num).toDouble(),
      points: json['points'] as int,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}