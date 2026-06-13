import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/enums/user_role.dart';
import '../../../common/screens/main_screen.dart';
import '../../../common/widgets/custom_appbar.dart';
import '../../../common/widgets/primary_button.dart';
import '../controllers/auth_cubit.dart';
import '../controllers/auth_state.dart';
import 'upload_license_screen.dart';

class VerificationStatusScreen
    extends StatefulWidget {
  const VerificationStatusScreen({
    super.key,
  });

  @override
  State<VerificationStatusScreen>
      createState() =>
          _VerificationStatusScreenState();
}

class _VerificationStatusScreenState
    extends State<VerificationStatusScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) {
      context
          .read<AuthCubit>()
          .getVerificationStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state
            is VerificationStatusLoaded) {

          if (state.status.isApproved) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => MainScreen(
                  role:
                      UserRole.therapist,
                ),
              ),
              (route) => false,
            );
          }
        }

        if (state is AuthFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(
            SnackBar(
              content: Text(
                state.message,
              ),
            ),
          );
        }
      },
      builder: (context, state) {

        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(
              child:
                  CircularProgressIndicator(),
            ),
          );
        }

        if (state
            is VerificationStatusLoaded) {

          /// Pending
          if (state.status.isPending) {
            return Scaffold(
              appBar: const CustomAppBar(
                title:
                    'Verification Status',
                showBackArrow: false,
              ),
              body: Padding(
                padding:
                    const EdgeInsets.all(
                  24,
                ),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .center,
                  children: [

                    const Icon(
                      Icons.hourglass_top,
                      size: 90,
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    const Text(
                      'Your license is under review',
                      textAlign:
                          TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    const Text(
                      'Please wait until an administrator reviews your license.',
                      textAlign:
                          TextAlign.center,
                    ),

                    const SizedBox(
                      height: 40,
                    ),

                    PrimaryButton(
                      title:
                          'Check Again',
                      width:
                          double.infinity,
                      onPressed: () {
                        context
                            .read<
                                AuthCubit>()
                            .getVerificationStatus();
                      },
                    ),
                  ],
                ),
              ),
            );
          }

          /// Rejected
          if (state.status.isRejected) {
            return Scaffold(
              appBar: const CustomAppBar(
                title:
                    'Verification Status',
                showBackArrow: false,
              ),
              body: Padding(
                padding:
                    const EdgeInsets.all(
                  24,
                ),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .center,
                  children: [

                    const Icon(
                      Icons.cancel_outlined,
                      size: 90,
                      color: Colors.red,
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    const Text(
                      'Your license was rejected',
                      textAlign:
                          TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    const Text(
                      'Please upload a new license and try again.',
                      textAlign:
                          TextAlign.center,
                    ),

                    const SizedBox(
                      height: 40,
                    ),

                    PrimaryButton(
                      title:
                          'Upload New License',
                      width:
                          double.infinity,
                      onPressed: () {
                        Navigator
                            .pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const UploadLicenseScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        }

        return const Scaffold(
          body: Center(
            child: Text(
              'Unable to load verification status',
            ),
          ),
        );
      },
    );
  }
}