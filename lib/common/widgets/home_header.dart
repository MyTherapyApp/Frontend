import 'package:flutter/material.dart';

import '../models/user_ui_model.dart';
// import 'header_action_button.dart';
import 'user_avatar.dart';

class HomeHeader extends StatelessWidget {
  final UserUIModel user;

  final List<Widget>? actions;

  const HomeHeader({
    super.key,

    required this.user,

    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Avatar
        UserAvatar(
          size: 54,

          imageUrl: user.imageUrl,
        ),

        const SizedBox(width: 14),

        /// Welcome Text
        Expanded(
          child: Text(
            'Welcome ${user.displayName}!',

            maxLines: 1,
            overflow: TextOverflow.ellipsis,

            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,

              color: Color(0xFF1E3A8A),
            ),
          ),
        ),

        /// Actions
        if (actions != null) ...[
          const SizedBox(width: 12),

          Row(
            children: actions!,
          ),
        ],
      ],
    );
  }
}