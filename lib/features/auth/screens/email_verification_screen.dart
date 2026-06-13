import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/enums/user_role.dart';
import '../../../common/helpers/snackbar_helper.dart';
import '../../../common/helpers/validators.dart';
import '../../../common/widgets/custom_appbar.dart';
import '../../../common/widgets/custom_text_button.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../common/widgets/primary_button.dart';
import '../controllers/auth_cubit.dart';
import '../controllers/auth_state.dart';
import 'login_screen.dart';
import 'otp_verification_screen.dart';


class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState
    extends State<EmailVerificationScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController =
      TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is VerificationCodeSent) {
          SnackbarHelper.show(
            context,
            state.message,
          );

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  OtpVerificationScreen(
                email: emailController.text.trim(),
              ),
            ),
          );
        }

        if (state is AuthFailure) {
          SnackbarHelper.show(
            context,
            state.message,
          );
        }
      },

      builder: (context, state) {
        final isLoading =
            state is AuthLoading;

        return Scaffold(
          appBar: const CustomAppBar(
            title: 'Verification',
            showBackArrow: true,
          ),

          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
              
                      const Text(
                        'Enter your email address to receive a verification code.',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
              
                      const SizedBox(
                        height: 32,
                      ),
              
                      CustomTextField(
                        controller:
                            emailController,
                        title: 'Email',
                        hintText:
                            'example@email.com',
                        keyboardType:
                            TextInputType.emailAddress,
                        validator:
                            Validators.email,
                      ),
              
                      const SizedBox(height: 50,),
              
                      PrimaryButton(
                        title:
                            'Send Code',
                        loading:
                            isLoading,
                        onPressed: () {
                          if (!_formKey
                              .currentState!
                              .validate()) {
                            return;
                          }
              
                          context
                              .read<AuthCubit>()
                              .sendVerificationCode(
                                email:
                                    emailController
                                        .text
                                        .trim(),
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
                              builder: (context) =>
                                  const LoginScreen(role: UserRole.patient,),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                      
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