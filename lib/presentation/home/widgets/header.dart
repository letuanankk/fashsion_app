import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_shop_app/data/auth/models/user.dart';

import '/../../common/helper/navigator/app_navigator.dart';
import '/../../core/configs/assets/app_images.dart';
import '/../../core/configs/assets/app_vectors.dart';
import '/../../core/configs/theme/app_colors.dart';
import '/../../domain/auth/entity/user.dart';
import '/../../presentation/cart/pages/cart.dart';
import '/../../presentation/home/bloc/user_info_display_cubit.dart';
import '/../../presentation/settings/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/user_info_display_state.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserInfoDisplayCubit()..displayUserInfo(),
      child: Padding(
        padding: const EdgeInsets.only(top: 40, right: 16, left: 16),
        child: BlocBuilder<UserInfoDisplayCubit, UserInfoDisplayState>(
          builder: (context, state) {
            if (state is UserInfoLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is UserInfoLoaded) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _profileImage(state.user, context),
                  _gender(state.user),
                  _card(context),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Stream<UserEntity> userData(String userId) {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .snapshots()
        .map((event) => UserModel.fromMap(event.data()!).toEntity());
  }

  Widget _profileImage(UserEntity user, BuildContext context) {
    return StreamBuilder<UserEntity>(
      stream: userData(user.userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final userModel = snapshot.data!;
        return GestureDetector(
          onTap: () {
            AppNavigator.push(context, SettingsPage(user: user));
          },
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    userModel.image.isEmpty
                        ? const AssetImage(AppImages.profile)
                        : NetworkImage(userModel.image),
              ),
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  Widget _gender(UserEntity user) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.secondBackground,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: Text(
          user.gender == 1 ? 'Men' : 'Women',
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ),
    );
  }

  Widget _card(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.push(context, const CartPage());
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
