import 'package:flutter/material.dart';
import 'package:my_therapy/common/widgets/custom_appbar.dart';

import '../../notifications/screens/notification_screen.dart';

class TherapistNotificationTab extends StatelessWidget {
  const TherapistNotificationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Notification', showBackArrow: false,),
      body: NotificationScreen(),
    );
  }
}