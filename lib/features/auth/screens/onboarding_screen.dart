import 'package:flutter/material.dart';
import 'package:my_therapy/common/theme/app_colors.dart'; 
import 'package:my_therapy/common/widgets/primary_button.dart';
import 'package:my_therapy/features/auth/screens/role_selection_screen.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();
  int currentPage = 0;

  final List<Map<String, String>> data = [
    {
      "image": "assets/images/on1.png",
      "title": "Welcome to My Therapy!",
      "desc": "A calm space made just for you to breathe, talk, and heal, Your journey to peace of mind starts here."
    },
    {
      "image": "assets/images/on2.png",
      "title": "Real Help, Real People",
      "desc": "Connect with kind, licensed therapists who truly listen, We’re here for you anytime, anywhere.",
    },
    {
      "image": "assets/images/on3.png",
      "title": "Safe & Confidential",
      "desc": "Everything you share stays private, You can open up freely, this is your safe space.",
    },
    {
      "image": "assets/images/on4.png",
      "title": "At My Therapy, your comfort comes first",
      "desc": "Join sessions anytime, by voice or video your comfort your choice stay anonymous if you want Healing begins when you feel safe.",
    },
    {
      "image": "assets/images/on5.png",
      "title": "Begin Your Journey",
      "desc": "You deserve peace of mind Take the first step and connect with your therapist today.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Back Button
            Align(
              alignment: Alignment.centerLeft,
              child: currentPage > 0
                  ? IconButton(
                      onPressed: () => controller.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      ),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: 20),
                    )
                  : const SizedBox(height: 48),
            ),

            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: data.length,
                onPageChanged: (index) => setState(() => currentPage = index),
                itemBuilder: (_, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image Handling
                        SizedBox(
                          height: height * 0.32,
                          child: Image.asset(
                            data[index]["image"]!,
                            fit: BoxFit.contain,
                            width: index == 1 ? width * 0.95 : (index == 3 ? width * 0.65 : width * 0.8),
                          ),
                        ),
                        SizedBox(height: height * 0.04),

                        // 1. Indicators (Modified to be circular)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(data.length, (i) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: currentPage == i ? AppColors.primary : AppColors.border,
                              shape: BoxShape.circle,
                            ),
                          )),
                        ),
                        SizedBox(height: height * 0.05),

                        // Title
                        Text(
                          data[index]["title"]!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: width * 0.065,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        
                        // Description
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                          child: Text(
                            data[index]["desc"]!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.hint,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Navigation Buttons
            Padding(
              padding: EdgeInsets.only(
                left: width * 0.08, 
                right: width * 0.08, 
                bottom: height * 0.07,
              ),
              child: Row(
                mainAxisAlignment: currentPage == data.length - 1 
                    ? MainAxisAlignment.center 
                    : MainAxisAlignment.spaceBetween,
                children: [
                  if (currentPage != data.length - 1)
                    SizedBox(
                      width: width * 0.28,
                      child: PrimaryButton(
                        title: "Skip",
                        height: height * 0.06,
                        onPressed: () => _finish(),
                      ),
                    ),

                  currentPage == data.length - 1
                      ? SizedBox(
                          width: width * 0.6, 
                          child: PrimaryButton(
                            title: "Get Started",
                            height: height * 0.06,
                            onPressed: () => _finish(),
                          ),
                        )
                      : GestureDetector(
                          onTap: () => controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          ),
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _finish() {
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(builder: (context) => const RoleSelectionScreen()),
    );
  }
}