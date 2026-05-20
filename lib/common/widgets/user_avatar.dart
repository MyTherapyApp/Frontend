import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final double size;

  final String? imageUrl;

  final bool editable;

  final VoidCallback? onEditTap;

  final Color backgroundColor;

  final Color borderColor;

  const UserAvatar({
    super.key,

    required this.size,

    this.imageUrl,

    this.editable = false,

    this.onEditTap,

    this.backgroundColor = const Color(0xFFE5E7EB),

    this.borderColor = Colors.white,
  });

  bool get hasImage {
    return imageUrl != null && imageUrl!.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,

      child: Stack(
        clipBehavior: Clip.none,

        children: [
          /// Avatar
          Container(
            width: size,
            height: size,

            decoration: BoxDecoration(
              shape: BoxShape.circle,

              color: backgroundColor,

              border: Border.all(
                color: borderColor,
                width: 2,
              ),
            ),

            child: ClipOval(
              child: hasImage
                  ? Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,

                      errorBuilder:
                          (_, __, ___) {
                        return _buildFallbackIcon();
                      },
                    )
                  : _buildFallbackIcon(),
            ),
          ),

          /// Camera Icon
          if (editable)
            Positioned(
              right: -2,
              bottom: -2,

              child: GestureDetector(
                onTap: onEditTap,

                child: Container(
                  width: size * 0.30,
                  height: size * 0.30,

                  decoration: BoxDecoration(
                    color: const Color(0xFF3F5AA6),

                    shape: BoxShape.circle,

                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),

                  child: Icon(
                    Icons.camera_alt_rounded,

                    color: Colors.white,

                    size: size * 0.14,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFallbackIcon() {
    return Icon(
      Icons.person_rounded,

      size: size * 0.45,

      color: Colors.white,
    );
  }
}