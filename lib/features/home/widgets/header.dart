import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_shop_app/common/widgets/loading/loading.dart';
import 'package:my_shop_app/data/auth/models/user.dart';
import 'package:my_shop_app/features/auth/controller/auth_controller.dart';
import '/../../common/helper/navigator/app_navigator.dart';
import '/../../core/configs/assets/app_images.dart';
import '/../../core/configs/assets/app_vectors.dart';
import '/../../core/configs/theme/app_colors.dart';
import '../../cart/screens/cart.dart';
import '../../settings/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends ConsumerWidget {
  final String userId;
  const Header({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 16, left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_profileImage(userId, context, ref), _card(context, userId)],
      ),
    );
  }

  Widget _profileImage(String userId, BuildContext context, WidgetRef ref) {
    return StreamBuilder<UserModel>(
      stream: ref.watch(authControllerProvider).getUserData(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }
        final userModel = snapshot.data!;
        return GestureDetector(
          onTap: () {
            AppNavigator.push(context, SettingsPage(userId: userId));
          },
          child: SizedBox(
            height: 40,
            width: 40,
            child: CircleAvatar(
              backgroundImage:
                  userModel.image.isEmpty
                      ? const AssetImage(AppImages.profile)
                      : NetworkImage(userModel.image),
              radius: 70,
            ),
          ),
        );
      },
    );
  }

  Widget _card(BuildContext context, String userId) {
    return GestureDetector(
      onTap: () {
        AppNavigator.push(context, CartPage());
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(AppVectors.bag, fit: BoxFit.none),
      ),
    );
  }
}
