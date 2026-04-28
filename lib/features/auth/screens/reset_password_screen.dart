import 'package:flutter/material.dart';
import 'package:my_therapy/common/theme/app_colors.dart';

import '../../../common/enums/user_role.dart';
import '../../../common/helpers/validators.dart';
import '../../../common/widgets/custom_appBar.dart';
import '../../../common/widgets/custom_text_button.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../common/widgets/dismiss_keyboard.dart';

class ResetPasswordScreen extends StatefulWidget {
  final UserRole role;
  const ResetPasswordScreen({super.key,required this.role,});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void resetPassword() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      /// send reset link / otp
    }
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          title: 'Forget Password',
          showBackArrow: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 30,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 70),
            
                    /// Email
                    CustomTextField(
                      controller: emailController,
                      title: 'Email',
                      hintText: 'mail@gmail.com',
                      keyboardType: TextInputType.emailAddress,
                      validator: Validators.email,
                      textInputAction: TextInputAction.done,
                      suffixIcon: const Icon(
                        Icons.email,
                        color: AppColors.hint,
                      ),
                    ),
            
                    const SizedBox(height: 20),
            
                    /// Reset
                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomTextButton(
                        text: 'Reset',
                        onPressed: resetPassword,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}