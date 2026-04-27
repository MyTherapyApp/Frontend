import 'package:flutter/material.dart';
import 'package:my_therapy/common/theme/app_colors.dart';
import 'package:my_therapy/features/auth/screens/reset_password_screen.dart';
import 'package:my_therapy/features/auth/screens/role_selection_screen.dart';

import '../../../common/helpers/validators.dart';
import '../../../common/widgets/custom_appBar.dart';
import '../../../common/widgets/custom_text_button.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../common/widgets/dismiss_keyboard.dart';
import '../../../common/widgets/primary_button.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

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

  void login() {
    if (_formKey.currentState!.validate()) {
      /// login logic
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    validator: Validators.password,
                    textInputAction: TextInputAction.done,
                  ),

                  const SizedBox(height: 18),

                  /// Remember me + Forget Password
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value!;
                          });
                        },
                      ),

                      const Text('Remember me',
                      style: TextStyle(
                        fontSize: 18
                      ),
                      ),

                      const Spacer(),

                      CustomTextButton(
                        text: 'Forget Password',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
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
                      
                    onPressed: login,
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
                        MaterialPageRoute(builder: (context) => RoleSelectionScreen()),
                      );
                    },

                  ),

                  const SizedBox(height: 35),

                  /// Continue With
                  const Text(
                    'or continue with',
                    style: TextStyle(fontSize: 15),
                  ),

                  const SizedBox(height: 18),

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