import 'package:flutter/material.dart';

import '../../../common/widgets/custom_appbar.dart';
import '../../notifications/screens/notification_screen.dart';

class PatientNotificationTab extends StatelessWidget {
  const PatientNotificationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Notification', showBackArrow: false,),
      body: NotificationScreen(),
      );
  }
}