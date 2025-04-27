import 'package:my_shop_app/presentation/settings/widgets/view_profile.dart';
import '../../../domain/auth/entity/user.dart';
import '/../../common/widgets/appbar/app_bar.dart';
import '/../../presentation/settings/widgets/my_orders_tile.dart';
import 'package:flutter/material.dart';

import '../widgets/my_favorties_tile.dart';

class SettingsPage extends StatelessWidget {
  final UserEntity user;
  const SettingsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(title: Text('Settings')),
      body: Padding(
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
      ),
    );
  }
}
