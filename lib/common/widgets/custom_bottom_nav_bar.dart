import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class NavItem {
  final IconData icon;
  final String label;

  const NavItem({
    required this.icon,
    required this.label,
  });
}

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final List<NavItem> items;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 82,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: const BoxDecoration(
          color: AppColors.navBackground,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(46),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final isSelected = currentIndex == index;

            return Expanded(
              child: InkWell(
                onTap: () => onTap(index),
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        items[index].icon,
                        size: 24,
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.navUnselected,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        items[index].label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.navUnselected,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}