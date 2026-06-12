import 'package:flutter/material.dart';
import 'package:my_therapy/common/theme/app_colors.dart';
import 'package:my_therapy/features/admin/admin_pending_screen.dart';
import 'package:my_therapy/features/auth/screens/reset_password_screen.dart';
import 'package:my_therapy/features/auth/screens/role_selection_screen.dart';
import 'package:my_therapy/features/auth/screens/verification_status_screen.dart';

import '../../../common/enums/user_role.dart';
import '../../../common/helpers/validators.dart';
import '../../../common/screens/main_screen.dart';
import '../../../common/widgets/custom_appbar.dart';
import '../../../common/widgets/custom_text_button.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../common/widgets/dismiss_keyboard.dart';
import '../../../common/widgets/primary_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/auth_cubit.dart';
import '../controllers/auth_state.dart';


class LoginScreen extends StatefulWidget {
  final UserRole role;
  const LoginScreen({super.key,
  required this.role,});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool rememberMe = false;


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
  listener: (context, state) {
    if (state is AuthSuccess) {
      final authResponse = state.authResponse;
        print(authResponse.claims);
        print(authResponse.role);
      final role = state.authResponse.role;
          

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
      }

      else if (role == 'Therapist') {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => VerificationStatusScreen()
          ),
          (route) => false,
        );
      }

      else if (role == 'Admin') {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (_) => const AdminPendingScreen(),
    ),
    (route) => false,
  );
}
    }

    if (state is AuthFailure) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content:
              Text(state.message),
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
          title: 'Welcome Back!',
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

                  /// Email
                  CustomTextField(
                    controller: emailController,
                    title: 'Email',
                    hintText: 'mail@gmail.com',
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.email,
                    suffixIcon: const Icon(Icons.email,
                    color: AppColors.hint,),
                  ),

                  const SizedBox(height: 20),

                  /// Password
                  CustomTextField(
                    controller: passwordController,
                    title: 'Password',
                    hintText: '********',
                    isPassword: true,
                    validator: Validators.loginPassword,
                    textInputAction: TextInputAction.done,
                  ),

                  const SizedBox(height: 18),

                  /// Remember me + Forget Password
                  Row(
                    children: [
                      // Checkbox(
                      //   value: rememberMe,
                      //   onChanged: (value) {
                      //     setState(() {
                      //       rememberMe = value!;
                      //     });
                      //   },
                      // ),

                      // const Text('Remember me',
                      // style: TextStyle(
                      //   fontSize: 18
                      // ),
                      // ),

                      const Spacer(),

                      CustomTextButton(
                        text: 'Forget Password',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ResetPasswordScreen(role: widget.role,)),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// Login Button
                  PrimaryButton(
                    title: "Login",
                      width: double.infinity,
                      loading: isLoading,
                      
                    onPressed: (){
    FocusScope.of(context)
        .unfocus();

    if (!_formKey.currentState!
        .validate()) {
      return;
    }

    context
        .read<AuthCubit>()
        .login(
          email:
              emailController.text
                  .trim(),
          password:
              passwordController.text,
        );
  },
                  ),

                  const SizedBox(height: 50),

                  /// Sign Up Section
                  const Text(
                    "Don’t have an account?",
                    style: TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 20),

                  PrimaryButton(
                    title: "Sign Up",
                      width: double.infinity,
                      
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RoleSelectionScreen(verifiedEmail: '',)),
                      );
                    },

                  ),

                  const SizedBox(height: 35),


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