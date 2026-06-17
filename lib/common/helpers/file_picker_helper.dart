import 'package:file_picker/file_picker.dart' as fp;

class FilePickerHelper {
  /// Allows the user to pick a licence file (jpg, jpeg, png, pdf).
  /// Returns the selected [fp.PlatformFile], or null if cancelled.
  static Future<fp.PlatformFile?> pickLicence() async {
    final fp.FilePickerResult? result = await fp.FilePicker.platform.pickFiles(
      type: fp.FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      return result.files.first;
    }

    return null;
  }

  /// Profile image
  static Future<fp.PlatformFile?> pickProfileImage() async {
    final result =
        await fp.FilePicker.pickFiles(
      type: fp.FileType.custom,
      allowedExtensions: [
        'jpg',
        'jpeg',
        'png',
      ],
      allowMultiple: false,
    );

    if (result != null &&
        result.files.isNotEmpty) {
      return result.files.first;
    }

    return null;
  }
}