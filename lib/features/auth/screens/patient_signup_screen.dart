import 'package:flutter/material.dart';
import 'package:my_therapy/common/theme/app_colors.dart';
import 'package:my_therapy/features/auth/screens/login_screen.dart';

import '../../../common/helpers/validators.dart';
import '../../../common/widgets/custom_appBar.dart';
import '../../../common/widgets/custom_text_button.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../common/widgets/dismiss_keyboard.dart';
import '../../../common/widgets/primary_button.dart';

class PatientSignupScreen extends StatefulWidget {
  const PatientSignupScreen({super.key});

  @override
  State<PatientSignupScreen> createState() => _PatientSignupScreenState();
}

class _PatientSignupScreenState extends State<PatientSignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void signup() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      /// signup logic
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
                  const SizedBox(height: 30),

                  /// Full Name
                  CustomTextField(
                    controller: fullNameController,
                    title: 'Full Name',
                    hintText: 'Your Name',
                    validator: Validators.fullName,
                    
                  ),

                  const SizedBox(height: 20),

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

                  const SizedBox(height: 20),

                  /// Password
                  CustomTextField(
                    controller: passwordController,
                    title: 'Password',
                    hintText: '************',
                    isPassword: true,
                    validator: Validators.password,
                  ),

                  const SizedBox(height: 20),

                  /// Confirm Password
                  CustomTextField(
                    controller: confirmPasswordController,
                    title: 'Confirm Password',
                    hintText: '************',
                    isPassword: true,
                    validator: (value) => Validators.confirmPassword(
                      value,
                      passwordController.text,
                    ),
                      ),

                  const SizedBox(height: 20),

                  /// Phone Number
                  CustomTextField(
                    controller: phoneController,
                    title: 'Phone Number',
                    hintText: '0458692997864',
                    keyboardType: TextInputType.phone,
                    validator: Validators.requiredField,
                    textInputAction: TextInputAction.done,
                    suffixIcon: const Icon(
                      Icons.phone,
                      color: AppColors.hint,
                    ),
                  ),

                  const SizedBox(height: 35),

                  /// Sign Up Button
                  PrimaryButton(
                    title: 'sign up',
                    width: double.infinity,
                    onPressed: signup,
                  ),

                  const SizedBox(height: 25),

                  /// Divider Text
                  Row(
                    children: const [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'Or sign up with',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.hint,
                          ),
                        ),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// Google Button
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(30),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey.shade100,
                      child: Image.network(
                        'https://cdn-icons-png.flaticon.com/512/300/300221.png',
                        width: 22,
                      ),
                    ),
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
                              builder: (context) =>
                                  const LoginScreen(),
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