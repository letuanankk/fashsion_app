import 'package:flutter/material.dart';
import 'package:my_shop_app/presentation/settings/pages/view_profile_screen.dart';
import '../../../common/helper/navigator/app_navigator.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../domain/auth/entity/user.dart';

class ViewProfile extends StatelessWidget {
  final UserEntity user;
  const ViewProfile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.push(context, ViewProfileScreen(user: user));
      },
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.secondBackground,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'View Profile',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
            Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}
