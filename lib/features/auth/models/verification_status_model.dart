class VerificationStatusModel {
  final int verificationStatus;
  final String? verifiedAt;

  VerificationStatusModel({
    required this.verificationStatus,
    this.verifiedAt,
  });

  factory VerificationStatusModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return VerificationStatusModel(
      verificationStatus:
          json['verificationStatus'],
      verifiedAt:
          json['verifiedAt'],
    );
  }

  bool get isPending =>
      verificationStatus == 1;

  bool get isApproved =>
      verificationStatus == 2;

  bool get isRejected =>
      verificationStatus == 3;
}