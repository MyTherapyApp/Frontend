import 'package:flutter/material.dart';
import 'package:my_therapy/common/widgets/custom_appbar.dart';
import 'package:my_therapy/common/widgets/user_avatar.dart';
import '../../../common/helpers/file_picker_helper.dart';
import '../../../common/services/profile_service_impl.dart';

class TherapistEditProfileScreen extends StatefulWidget {
  const TherapistEditProfileScreen({super.key});

  @override
  State<TherapistEditProfileScreen> createState() => _TherapistEditProfileScreenState();
}

class _TherapistEditProfileScreenState extends State<TherapistEditProfileScreen> {

final ProfileServiceImpl _profileService = ProfileServiceImpl();
String? imageUrl;
bool isUploading = false;

Future<void> _pickAndUploadImage()
async {

  final file =
      await FilePickerHelper
          .pickProfileImage();

  if (file == null ||
      file.path == null) {
    return;
  }

  try {

    setState(() {
      isUploading = true;
    });

    final response =
        await _profileService
            .uploadProfilePicture(
      file.path!,
    );
    print(response.profilePictureUrl);

    setState(() {
      imageUrl =
          '${response.profilePictureUrl}?t=${DateTime.now().millisecondsSinceEpoch}';
    });

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      SnackBar(
        content: Text(
          response.message,
        ),
      ),
    );

  } catch (e) {

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      SnackBar(
        content: Text(
          e.toString(),
        ),
      ),
    );

  } finally {

    if (mounted) {
      setState(() {
        isUploading = false;
      });
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Edit Profile'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Center(
              child: Stack(
  alignment: Alignment.center,
  children: [

    UserAvatar(
      size: 140,

      imageUrl: imageUrl,

      editable: true,

      onEditTap:
          _pickAndUploadImage,
    ),

    if (isUploading)
      Container(
        width: 140,
        height: 140,

        decoration:
            const BoxDecoration(
          color: Colors.black26,
          shape: BoxShape.circle,
        ),

        child: const Center(
          child:
              CircularProgressIndicator(),
        ),
      ),
  ],
)
            )
          ],
        ),),
    );
  }
}