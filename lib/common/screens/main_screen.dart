import 'package:flutter/material.dart';
import 'package:my_therapy/features/patient/tabs/patient_chat_tab.dart';
import 'package:my_therapy/features/patient/tabs/patient_home_tab.dart';
import 'package:my_therapy/features/patient/tabs/patient_notification_tab.dart';
import 'package:my_therapy/features/patient/tabs/patient_profile_tab.dart';
import 'package:my_therapy/features/therapist/tabs/therapist_chat_tab.dart';
import 'package:my_therapy/features/therapist/tabs/therapist_home_tab.dart';
import 'package:my_therapy/features/therapist/tabs/therapist_notification_tab.dart';
import 'package:my_therapy/features/therapist/tabs/therapist_profile_tab.dart';
import '../enums/user_role.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  final UserRole role;

  const MainScreen({
    super.key,
    required this.role,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  late final List<Widget> tabs;

  @override
  void initState() {
    super.initState();

    tabs = widget.role == UserRole.patient
        ? _patientTabs()
        : _therapistTabs();
  }

  // ✅ تم تنظيف التابات وإزالة الباراميتر المسبب للخطأ
  List<Widget> _patientTabs() {
    return const [
      PatientHomeTab(), 
      PatientProfileTab(),
      PatientNotificationTab(),
      PatientChatTab(),
    ];
  }

  List<Widget> _therapistTabs() {
    return const [
      TherapistHomeTab(),
      TherapistProfileTab(),
      TherapistNotificationTab(),
      TherapistChatTab(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: tabs,
      ),

      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          NavItem(icon: Icons.home, label: "Home"),
          NavItem(icon: Icons.person, label: "Profile"),
          NavItem(icon: Icons.notifications, label: "Notification"),
          NavItem(icon: Icons.chat_bubble , label: "Chat"),
        ],
      ),
    );
  }
}