import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_therapy/common/enums/user_role.dart';
import 'package:my_therapy/common/theme/app_colors.dart';
import 'package:my_therapy/features/auth/screens/email_verification_screen.dart';
import 'package:my_therapy/features/auth/screens/login_screen.dart';

import '../../../common/helpers/validators.dart';
import '../../../common/screens/main_screen.dart';
import '../../../common/widgets/custom_appbar.dart';
import '../../../common/widgets/custom_text_button.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../common/widgets/dismiss_keyboard.dart';
import '../../../common/widgets/primary_button.dart';
import '../controllers/auth_cubit.dart';
import '../controllers/auth_state.dart';

class PatientSignupScreen extends StatefulWidget {
  final String verifiedEmail;
  const PatientSignupScreen({
    super.key,
    required this.verifiedEmail,
  });

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
  int? selectedGender;

DateTime? selectedDate;

bool isAnonymous = false;

final dateController = TextEditingController();

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
  phoneController.dispose();
  dateController.dispose();
  super.dispose();
}



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
  listener: (context, state) {
  if (state is AuthSuccess) {
    final role =
        state.authResponse.role;

    if (role == 'Patient') {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => MainScreen(
            role: UserRole.patient,
          ),
        ),
        (route) => false,
      );
    } else if (role == 'Therapist') {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => MainScreen(
            role: UserRole.therapist,
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
    final isLoading =
        state is AuthLoading;

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
                    readOnly: true,
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
                    validator: Validators.phone,
                    textInputAction: TextInputAction.next,
                    suffixIcon: const Icon(
                      Icons.phone,
                      color: AppColors.hint,
                    ),
                  ),
                  const SizedBox(height: 20),

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
const SizedBox(height: 20,),
CustomTextField(
  controller: dateController,
  title: 'Date of Birth',
  hintText: 'Select date',
  readOnly: true,
  onTap: () async {
    final picked =
        await showDatePicker(
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
const SizedBox(height: 20,),
CheckboxListTile(
  value: isAnonymous,
  contentPadding: EdgeInsets.zero,
  title: const Text(
    'Register Anonymously',
  ),
  onChanged: (value) {
    setState(() {
      isAnonymous =
          value ?? false;
    });
  },
),

                  const SizedBox(height: 35),

                  /// Sign Up Button
                  PrimaryButton(
                    title: 'sign up',
                    width: double.infinity,
                    loading: isLoading,
                    onPressed: () {
  FocusScope.of(context).unfocus();

  if (!_formKey.currentState!
      .validate()) {
    return;
  }

  if (selectedGender == null) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content:
            Text('Select gender'),
      ),
    );
    return;
  }

  if (selectedDate == null) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          'Select date of birth',
        ),
      ),
    );
    return;
  }

  context
      .read<AuthCubit>()
      .registerPatient(
        fullName:
            fullNameController.text
                .trim(),
        email:
            emailController.text
                .trim(),
        password:
            passwordController.text,
        phone:
            phoneController.text
                .trim(),
        gender:
            selectedGender!,
        dateOfBirth:
            selectedDate!,
        isAnonymous:
            isAnonymous,
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
                        style: TextStyle(fontSize: 16),
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