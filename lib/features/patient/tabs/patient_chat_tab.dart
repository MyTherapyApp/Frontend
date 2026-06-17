import 'package:flutter/material.dart';

import '../../chat/widgets/custom_gradient_appbar.dart';

class PatientChatTab extends StatelessWidget {
  const PatientChatTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomGradientAppBar(
        title: 'Messages',
        showBackButton: false,
        showSearch: true,
        
      ),
      body: Center(child: Text("Patient Chat")),
    );
  }
}