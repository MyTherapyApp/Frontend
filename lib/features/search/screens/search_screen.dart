import 'package:flutter/material.dart';
import 'package:my_therapy/common/widgets/custom_appbar.dart';

import '../../../common/enums/user_role.dart';
import '../../../common/theme/app_colors.dart';
import '../../../common/widgets/custom_search_field.dart';
import '../../../common/widgets/header_action_button.dart';

class SearchScreen extends StatefulWidget {
  final UserRole role;
  const SearchScreen({super.key, required this.role,});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.role == UserRole.therapist
          ? 'Patients List'
          : 'Doctor List',
        showBackArrow: true,
        action: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFEBF4FB),
          ),
          child: HeaderActionButton(
                    icon: Icons.tune_rounded,
                    onTap: () {},
                  ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: CustomSearchField(
          hintText: widget.role == UserRole.therapist
              ? 'Search a Patient...'
              : 'Search a Doctor...',
          autofocus: true,
        ),
      ),
    );
  }
}