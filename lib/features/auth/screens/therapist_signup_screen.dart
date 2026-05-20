import 'package:flutter/material.dart';
import 'package:my_therapy/common/enums/user_role.dart';
import 'package:my_therapy/common/theme/app_colors.dart';
import 'package:my_therapy/features/auth/screens/login_screen.dart';

import '../../../common/helpers/validators.dart';
import '../../../common/screens/main_screen.dart';
import '../../../common/widgets/custom_appbar.dart';
import '../../../common/widgets/custom_text_button.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../common/widgets/dismiss_keyboard.dart';
import '../../../common/widgets/primary_button.dart';
import 'package:file_picker/file_picker.dart' as fp;
import '../../../common/helpers/file_picker_helper.dart';

class TherapistSignupScreen extends StatefulWidget {
  const TherapistSignupScreen({super.key});

  @override
  State<TherapistSignupScreen> createState() => _TherapistSignupScreenState();
}

class _TherapistSignupScreenState extends State<TherapistSignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final specializationController = TextEditingController();
  final experienceController = TextEditingController();
  final phoneController = TextEditingController();

  fp.PlatformFile? _selectedLicenceFile;


  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    specializationController.dispose();
    experienceController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void signUp() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MainScreen(
            role: UserRole.therapist,
          ),
        ),
      );
    }

  }

  Future<void> _pickLicence() async {
    final fp.PlatformFile? file = await FilePickerHelper.pickLicence();
    if (file != null) {
      setState(() {
        _selectedLicenceFile = file;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          title: 'Sign Up',
          showBackArrow: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 25),

                  /// Full Name
                  CustomTextField(
                    controller: fullNameController,
                    title: 'Full Name',
                    hintText: 'Your Name',
                    validator: Validators.fullName,
                  ),

                  const SizedBox(height: 18),

                  /// Email
                  CustomTextField(
                    controller: emailController,
                    title: 'Email',
                    hintText: 'mail@gmail.com',
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.email,
                    suffixIcon: const Icon(
                      Icons.email,
                      color: AppColors.hint,
                    ),
                  ),

                  const SizedBox(height: 18),

                  /// Password
                  CustomTextField(
                    controller: passwordController,
                    title: 'Password',
                    hintText: '********',
                    isPassword: true,
                    validator: Validators.password,
                  ),

                  const SizedBox(height: 18),

                  /// Confirm Password
                  CustomTextField(
                    controller: confirmPasswordController,
                    title: 'Confirm Password',
                    hintText: '********',
                    isPassword: true,
                    validator: (value) => Validators.confirmPassword(
                      value,
                      passwordController.text,
                    ),
                  ),

                  const SizedBox(height: 18),

                  /// Specialization
                  CustomTextField(
                    controller: specializationController, 
                    title: 'Specialization', 
                    hintText: 'Mental Health',
                    validator: Validators.specialization,
                    // suffixIcon: const Icon(
                    //   Icons.arrow_drop_down ,
                    //   color: AppColors.hint,
                    // ),
                    ),

                  const SizedBox(height: 18),

                  /// Experience
                  CustomTextField(
                    controller: experienceController,
                    title: 'Experience',
                    hintText: '+3 Years',
                    validator: Validators.experience,
                  ),

                  const SizedBox(height: 18),

                  /// Phone Number
                  CustomTextField(
                    controller: phoneController,
                    title: 'Phone Number',
                    hintText: '4585697456',
                    keyboardType: TextInputType.phone,
                    validator: Validators.phone,
                    textInputAction: TextInputAction.done,
                  ),

                  const SizedBox(height: 12),

                  /// Upload Licence
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextButton(
                          text: _selectedLicenceFile == null
                              ? 'Upload Licence'
                              : _selectedLicenceFile!.name,
                          onPressed: _pickLicence,
                        ),
                        if (_selectedLicenceFile != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 4, left: 4),
                            child: Text(
                              '✓ File selected',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.green.shade600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  /// Sign Up
                  PrimaryButton(
                    title: 'SignUp',
                    width: double.infinity,
                    onPressed: signUp,
                  ),

                  const SizedBox(height: 25),

                  /// Already have account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account? ',
                        style: TextStyle(fontSize: 14),
                      ),
                      CustomTextButton(
                        text: 'Login',
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(role: UserRole.therapist,),
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}