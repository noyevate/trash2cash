class LoginResponseModel {
  final int id;
  final String firstName;
  final double walletBalance;
  final int points;
  final String accessToken;
  final String refreshToken;

  LoginResponseModel({
    required this.id,
    required this.firstName,
    required this.walletBalance,
    required this.points,
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      id: json['id'] as int,
      firstName: json['firstName'] as String,
      walletBalance: (json['walletBalance'] as num).toDouble(),
      points: json['points'] as int,
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );
  }
}