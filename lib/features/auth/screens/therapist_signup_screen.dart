import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_therapy/common/enums/user_role.dart';
import 'package:my_therapy/common/theme/app_colors.dart';
import 'package:my_therapy/features/auth/screens/login_screen.dart';

import '../../../common/helpers/validators.dart';
import '../../../common/widgets/custom_appbar.dart';
import '../../../common/widgets/custom_text_button.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../common/widgets/dismiss_keyboard.dart';
import '../../../common/widgets/primary_button.dart';
import '../controllers/auth_cubit.dart';
import '../controllers/auth_state.dart';
import 'email_verification_screen.dart';
import 'upload_license_screen.dart';

class TherapistSignupScreen extends StatefulWidget {
  final String verifiedEmail;
  const TherapistSignupScreen({super.key,required this.verifiedEmail});

  @override
  State<TherapistSignupScreen> createState() => _TherapistSignupScreenState();
}

class _TherapistSignupScreenState extends State<TherapistSignupScreen> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();
final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final specializationController = TextEditingController();
  final licenseNumberController = TextEditingController();
  final phoneController = TextEditingController();
  final dateController = TextEditingController();

  int? selectedGender;
  DateTime? selectedDate;

  // fp.PlatformFile? _selectedLicenceFile;

@override
void initState() {
  super.initState();

  emailController.text =
      widget.verifiedEmail;
}
  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    specializationController.dispose();
    licenseNumberController.dispose();
    phoneController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(state.message),
      ),
    );
  }
  if (state is AuthSuccess) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const UploadLicenseScreen(),
      ),
    );
  }

        // AuthSuccess handling (navigation to Upload License screen)
        // will be added in the next phase.
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

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
                    readOnly: true,
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

                  /// License Number
                  CustomTextField(
                    controller: licenseNumberController,
                    title: 'License Number',
                    hintText: 'Enter your license number',
                    validator: Validators.requiredField,
                  ),

                  const SizedBox(height: 18),

                  /// Gender
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Gender',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  RadioListTile<int>(
                    title: const Text('Male'),
                    value: 1,
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                  ),

                  RadioListTile<int>(
                    title: const Text('Female'),
                    value: 2,
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                  ),

                  const SizedBox(height: 18),

                  /// Date of Birth
                  CustomTextField(
                    controller: dateController,
                    title: 'Date of Birth',
                    hintText: 'Select date',
                    readOnly: true,
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1950),
                        lastDate: DateTime.now(),
                        initialDate: DateTime(2000),
                      );

                      if (picked != null) {
                        selectedDate = picked;

                        dateController.text =
                            '${picked.day}/${picked.month}/${picked.year}';

                        setState(() {});
                      }
                    },
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

                  const SizedBox(height: 18),

                  /// Sign Up
                  /// Sign Up
                  PrimaryButton(
                    title: 'SignUp',
                    width: double.infinity,
                    loading: isLoading,
                    onPressed: () {
                      FocusScope.of(context).unfocus();

                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      if (selectedGender == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Select gender'),
                          ),
                        );
                        return;
                      }

                      if (selectedDate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Select date of birth'),
                          ),
                        );
                        return;
                      }

                      context.read<AuthCubit>().registerTherapist(
                            fullName: fullNameController.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text,
                            phone: phoneController.text.trim(),
                            gender: selectedGender!,
                            dateOfBirth: selectedDate!,
                            isAnonymous: false,
                            specialization:
                                specializationController.text.trim(),
                            licenseNumber:
                                licenseNumberController.text.trim(),
                          );
                    },
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Go Verify Your Email? ',
                        style: TextStyle(fontSize: 16),
                      ),
                      CustomTextButton(
                        text: 'Email Verification',
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const EmailVerificationScreen(),
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
        },
  );
  }
}