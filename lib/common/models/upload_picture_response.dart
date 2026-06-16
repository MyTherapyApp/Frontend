class UploadPictureResponse {
  final String message;
  final String profilePictureUrl;

  UploadPictureResponse({
    required this.message,
    required this.profilePictureUrl,
  });

  factory UploadPictureResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return UploadPictureResponse(
      message: json['message'] ?? '',
      profilePictureUrl:
          json['profilePictureUrl'] ?? '',
    );
  }
}