import 'package:file_picker/file_picker.dart' as fp;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/helpers/file_picker_helper.dart';
import '../../../common/widgets/custom_appbar.dart';
import '../../../common/widgets/primary_button.dart';
import '../controllers/auth_cubit.dart';
import '../controllers/auth_state.dart';
import 'verification_status_screen.dart';

class UploadLicenseScreen extends StatefulWidget {
  const UploadLicenseScreen({
    super.key,
  });

  @override
  State<UploadLicenseScreen> createState() =>
      _UploadLicenseScreenState();
}

class _UploadLicenseScreenState
    extends State<UploadLicenseScreen> {
  fp.PlatformFile? selectedFile;

  Future<void> pickFile() async {
    final file =
        await FilePickerHelper.pickLicence();

    if (file != null) {
      setState(() {
        selectedFile = file;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LicenseUploaded) {
          ScaffoldMessenger.of(context)
              .showSnackBar(
            SnackBar(
              content: Text(
                state.message,
              ),
            ),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const VerificationStatusScreen(),
            ),
          );
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
        final isLoading =
            state is AuthLoading;

        return Scaffold(
          appBar: const CustomAppBar(
            title: 'Upload License',
            showBackArrow: false,
          ),
          body: Padding(
            padding:
                const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),

                const Icon(
                  Icons.description_outlined,
                  size: 90,
                ),

                const SizedBox(
                  height: 20,
                ),

                const Text(
                  'Upload Your Professional License',
                  textAlign: TextAlign.center,
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
                  'Supported formats: PDF, JPG, JPEG, PNG',
                  textAlign: TextAlign.center,
                ),

                const SizedBox(
                  height: 40,
                ),

                OutlinedButton(
                  onPressed: pickFile,
                  child: const Text(
                    'Choose File',
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                if (selectedFile != null)
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.all(
                      12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            Colors.grey.shade300,
                      ),
                      borderRadius:
                          BorderRadius.circular(
                        8,
                      ),
                    ),
                    child: Text(
                      selectedFile!.name,
                      textAlign:
                          TextAlign.center,
                    ),
                  ),

                const Spacer(),

                PrimaryButton(
                  title: 'Upload License',
                  width: double.infinity,
                  loading: isLoading,
                  onPressed: () {
                    if (selectedFile == null) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please select a license file',
                          ),
                        ),
                      );
                      return;
                    }

                    if (selectedFile!.path ==
                        null) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Invalid file selected',
                          ),
                        ),
                      );
                      return;
                    }

                    context
                        .read<AuthCubit>()
                        .uploadLicense(
                          filePath:
                              selectedFile!
                                  .path!,
                          fileName:
                              selectedFile!
                                  .name,
                        );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}