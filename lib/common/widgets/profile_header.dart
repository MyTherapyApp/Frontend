import 'package:flutter/material.dart';

import '../models/user_ui_model.dart';
import 'user_avatar.dart';

class ProfileHeader extends StatelessWidget {
  final UserUIModel user;

  final double avatarSize;

  final bool editable;

  final VoidCallback? onEditTap;

  const ProfileHeader({
    super.key,

    required this.user,

    this.avatarSize = 110,

    this.editable = false,

    this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Avatar
        UserAvatar(
          size: avatarSize,

          imageUrl: user.imageUrl,

          editable: editable,

          onEditTap: onEditTap,
        ),

        const SizedBox(height: 16),

        /// Name
        Text(
          user.displayName,

          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 6),

        // /// Role
        // Text(
        //   user.isTherapist
        //       ? 'Psychotherapist'
        //       : 'Patient',

        //   style: const TextStyle(
        //     fontSize: 14,
        //     color: Colors.grey,
        //   ),
        // ),
      ],
    );
  }
}