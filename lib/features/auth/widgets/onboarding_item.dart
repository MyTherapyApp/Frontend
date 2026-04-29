import 'package:flutter/material.dart';

class OnboardingItem extends StatelessWidget {
  final String image;
  final String title;
  final String desc;

  const OnboardingItem({
    super.key,
    required this.image,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.08),
      child: Column(
        children: [
          SizedBox(height: h * 0.05),

          /// الصورة
          Image.asset(
            image,
            width: w * 0.7,
            fit: BoxFit.contain,
          ),

          SizedBox(height: h * 0.04),

          /// dots هتتحط في الشاشة الرئيسية (تحت الصورة مباشرة)
          /// هنا هنسيب مسافة بس
          SizedBox(height: h * 0.02),

          /// العنوان
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),

          SizedBox(height: h * 0.015),

          /// الوصف
          Text(
            desc,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}