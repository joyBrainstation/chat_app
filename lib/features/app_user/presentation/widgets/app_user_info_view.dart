import 'package:chat_app/common/utils/asset_constants.dart';
import 'package:chat_app/features/app_user/application/app_user_info_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/user.dart';

class AppUserInfoView extends ConsumerWidget {
  const AppUserInfoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppUserInfoProvider provider = ref.read(appUserInfoProvider(context));

    return SizedBox(
        height: 70.0, child: _buildProfileSection(context, provider));
  }

  Widget _buildProfileSection(
      BuildContext context, AppUserInfoProvider provider) {
    User? user = provider.fetchUserData();
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: FadeInImage(
          placeholder: const AssetImage(AssetConstants.placeholderImage),
          image: NetworkImage(user?.photo ?? ''),
          fit: BoxFit.cover,
          width: 50.0, // Set the image width
          height: 50.0, // Set the image height
        ),
      ),
      title: Text(user?.name ?? '',
          style: Theme.of(context).primaryTextTheme.titleMedium),
      subtitle: Text(user?.email ?? '',
          style: Theme.of(context).primaryTextTheme.titleSmall),
      trailing: IconButton(
        onPressed: provider.logoutUser,
        icon: Icon(
          Icons.logout,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    );
  }
}
