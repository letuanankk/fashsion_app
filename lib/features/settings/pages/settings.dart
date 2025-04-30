import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_shop_app/common/widgets/loading/loading.dart';
import 'package:my_shop_app/data/auth/models/user.dart';
import 'package:my_shop_app/features/auth/controller/auth_controller.dart';
import 'package:my_shop_app/features/settings/widgets/view_profile.dart';
import '/../../common/widgets/appbar/app_bar.dart';
import '../widgets/my_orders_tile.dart';
import 'package:flutter/material.dart';

import '../widgets/my_favorties_tile.dart';

class SettingsPage extends ConsumerWidget {
  final String userId;
  const SettingsPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: BasicAppbar(title: Text('Settings')),
      body: StreamBuilder(
        stream: ref.watch(authControllerProvider).getUserData(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          UserModel user = snapshot.data!;
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                ViewProfile(user: user),
                SizedBox(height: 15),
                MyFavortiesTile(),
                SizedBox(height: 15),
                MyOrdersTile(),
              ],
            ),
          );
        },
      ),
    );
  }
}
