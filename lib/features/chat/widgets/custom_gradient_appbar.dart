import 'package:flutter/material.dart';

class CustomGradientAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String? title;

  final bool showBackButton;
  final bool showSearch;

  final VoidCallback? onBackPressed;
  final VoidCallback? onSearchPressed;

  // Chat mode
  final String? userName;
  final String? avatarUrl;
  final Widget? avatar;

  const CustomGradientAppBar({
    super.key,
    this.title,
    this.showBackButton = true,
    this.showSearch = false,
    this.onBackPressed,
    this.onSearchPressed,
    this.userName,
    this.avatarUrl,
    this.avatar,
  });

  bool get isChatMode => userName != null;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: !isChatMode, // title في النص فقط لو مش Chat Mode
      elevation: 0,
      backgroundColor: Colors.transparent,

      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF7B7CE6),
              Color(0xFFA96FE8),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),

      leading: showBackButton
          ? IconButton(
              onPressed: onBackPressed ?? () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 20,
              ),
            )
          : null,

      titleSpacing: isChatMode ? 0 : null,

      title: isChatMode
          ? Row(
              children: [
                avatar ??
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: avatarUrl != null
                          ? NetworkImage(avatarUrl!)
                          : null,
                    ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    userName!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            )
          : Text(
              title ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

      actions: [
        if (showSearch)
          IconButton(
            onPressed: onSearchPressed,
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}