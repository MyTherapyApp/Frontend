import 'package:flutter/material.dart';
import 'package:my_therapy/features/chat/screens/chat_details_screen.dart';

import '../../chat/data/mock_chat_previews.dart';
import '../../chat/widgets/chat_user_tile.dart';
import '../../chat/widgets/custom_gradient_appbar.dart';

class TherapistChatTab extends StatelessWidget {
  const TherapistChatTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomGradientAppBar(
        title: 'Messages',
        showBackButton: false,
        showSearch: true,
        
      ),
      body: SafeArea(
  child: ListView.separated(
    itemCount: mockChatPreviews.length,
    separatorBuilder: (_, __) =>
        const SizedBox(height: 4),
    itemBuilder: (context, index) {
      final chat = mockChatPreviews[index];
      return ChatUserTile(
        chat: chat,
        onTap: (){
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (_)=> ChatDetailsScreen(user: chat.user)));
        },
      );
    },
  ),
),
    );
  }
}