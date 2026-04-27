import 'package:flutter/material.dart';
import 'package:my_therapy/features/auth/screens/login_screen.dart';
import 'package:my_therapy/common/widgets/primary_button.dart';
import 'package:my_therapy/features/auth/screens/patient_signup_screen.dart';
import 'package:my_therapy/features/auth/screens/therapist_signup_screen.dart';
class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.06,
            ),
            child: Column(
              children: [
                SizedBox(height: height * 0.06),
                    
                /// Image
                Center(
                  child: Image.asset(
                    "assets/images/role.png",
                    width: width * 0.62,
                    height: height * 0.28,
                    fit: BoxFit.contain,
                  ),
                ),
          
                SizedBox(height: height * 0.04),
          
                /// Title
                Text(
                  "Join Us as a Patient or\nTherapist",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: width * 0.065,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    height: 1.3,
                  ),
                ),
          
                SizedBox(height: height * 0.08),
          
                /// Therapist Button
                PrimaryButton(
                  title: "I’m a Therapist",
                  width: double.infinity,
                  height: height * 0.065,
                  onPressed: () {
                    /// Navigate Therapist Login
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TherapistSignupScreen()),
                      );
                  },
                ),
          
                SizedBox(height: height * 0.02),
          
                /// Patient Button
                PrimaryButton(
                  title: "I’m a Patient",
                  width: double.infinity,
                  height: height * 0.065,
                  onPressed: () {
                    /// Navigate Patient Login
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PatientSignupScreen()),
                      );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}