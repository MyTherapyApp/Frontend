import 'package:flutter/material.dart';
import 'package:my_therapy/common/enums/user_role.dart';
import 'package:my_therapy/common/widgets/custom_appbar.dart';
import 'package:my_therapy/common/widgets/user_avatar.dart';
import '../../../common/helpers/file_picker_helper.dart';
import '../../../common/helpers/snackbar_helper.dart';
import '../../../common/screens/main_screen.dart';
import '../../../common/services/auth_helper.dart';
import '../../../common/services/profile_service_impl.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../common/widgets/primary_button.dart';
import '../services/therapist_profile_service.dart';

class TherapistEditProfileScreen extends StatefulWidget {
  const TherapistEditProfileScreen({super.key});

  @override
  State<TherapistEditProfileScreen> createState() => _TherapistEditProfileScreenState();
}

class _TherapistEditProfileScreenState extends State<TherapistEditProfileScreen> {

final ProfileServiceImpl _profileService = ProfileServiceImpl();
String? imageUrl= 'https://i.pravatar.cc/300';
bool isUploading = false;

final fullNameController = TextEditingController();
final emailController = TextEditingController();
final phoneController = TextEditingController();
final bioController = TextEditingController();
final specializationController = TextEditingController();
final experienceYearsController = TextEditingController();

final TherapistProfileService _therapistProfileService = TherapistProfileService();

bool isLoading = true;


@override
void initState() {
  super.initState();
  _loadProfile();
}
Future<void> _loadProfile() async {
  try {

    final profile =
        await _therapistProfileService
            .getTherapistProfile();
            print(profile.fullName);
print(profile.phone);
print(profile.bio);
print(profile.profilePicture);
        fullNameController.text= profile.fullName;
    emailController.text = await AuthHelper.getEmail() ?? '';
    phoneController.text = profile.phone;
    bioController.text = profile.bio ?? '';
    specializationController.text = profile.specialization ?? '';
experienceYearsController.text = profile.experienceYears.toString();

    imageUrl =
        profile.profilePicture;

  } catch (e) {

    print(e);

  } finally {

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }
}
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
void dispose() {
  fullNameController.dispose();
  emailController.dispose();
  phoneController.dispose();
  bioController.dispose();
  specializationController.dispose();
experienceYearsController.dispose();

  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Profile Details',showBackArrow: true,),
      body: isLoading
    ? const Center(
        child:
            CircularProgressIndicator(),
      )
    : SingleChildScrollView(
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
),
            ),
            const SizedBox(height: 24),
            CustomTextField(
              controller: fullNameController,
              title: 'Full Name',
              hintText: 'Enter your full name',
            ),

    const SizedBox(height: 16),

//     CustomTextField(
//   controller: emailController,
//   title: 'Email',
//   hintText: 'Enter your email',
//   readOnly: true,
//   keyboardType: TextInputType.emailAddress,
// ),

const SizedBox(height: 16),

CustomTextField(
  controller: phoneController,
  title: 'Phone Number',
  hintText: 'Enter your phone number',
  keyboardType: TextInputType.phone,
),

const SizedBox(height: 16),
const SizedBox(height: 16),

CustomTextField(
  controller:
      specializationController,
  title: 'Specialization',
  hintText:
      'Enter specialization',
),

const SizedBox(height: 16),

CustomTextField(
  controller:
      experienceYearsController,
  title: 'Experience Years',
  hintText:
      'Enter years of experience',
  keyboardType:
      TextInputType.number,
),

const SizedBox(height: 16),

CustomTextField(
  controller: bioController,
  title: 'Bio',
  hintText:
      'Tell us about yourself',
  maxLines: 4,
  textInputAction:
      TextInputAction.done,
),
const SizedBox(height: 16),

PrimaryButton(
  title: 'Save Changes',
  onPressed: () {

    SnackbarHelper.show(
      context,
      'Profile updated successfully',
    );

    Navigator.pop(context);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const MainScreen(role: UserRole.therapist,),
      ),
      (route) => false,
    );
  },
),
          ],
        ),),
    );
  }
}