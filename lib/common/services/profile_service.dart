import '../models/upload_picture_response.dart';

abstract class ProfileService {
  Future<UploadPictureResponse>
      uploadProfilePicture(
    String filePath,
  );
}