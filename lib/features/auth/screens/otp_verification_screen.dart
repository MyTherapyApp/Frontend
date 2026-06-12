import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/helpers/snackbar_helper.dart';
import '../../../common/widgets/custom_appbar.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../common/widgets/primary_button.dart';

import '../controllers/auth_cubit.dart';
import '../controllers/auth_state.dart';
import 'role_selection_screen.dart';

class OtpVerificationScreen
    extends StatefulWidget {
  final String email;

  const OtpVerificationScreen({
    super.key,
    required this.email,
  });

  @override
  State<OtpVerificationScreen>
      createState() =>
          _OtpVerificationScreenState();
}

class _OtpVerificationScreenState
    extends State<OtpVerificationScreen> {
  final _formKey = GlobalKey<FormState>();

  final otpController =
      TextEditingController();

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is EmailVerified) {
          SnackbarHelper.show(
            context,
            state.message,
          );

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  RoleSelectionScreen(
  verifiedEmail: widget.email,
)
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
            title: 'Verify Email',
            showBackArrow: true,
          ),

          body: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 24,
                    ),

                    Text(
                      'Code sent to ${widget.email}',
                    ),

                    const SizedBox(
                      height: 32,
                    ),

                    CustomTextField(
                      controller:
                          otpController,
                      title:
                          'Verification Code',
                      hintText:
                          'Enter code',
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty) {
                          return 'Enter verification code';
                        }

                        return null;
                      },
                    ),

                    const Spacer(),

                    PrimaryButton(
                      title: 'Verify',
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
                            .verifyEmail(
                              email:
                                  widget.email,
                              code:
                                  otpController
                                      .text
                                      .trim(),
                            );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}