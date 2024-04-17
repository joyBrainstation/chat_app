import 'package:chat_app/features/chat/presentation/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/utils/asset_constants.dart';
import '../../../app_user/domain/entities/user.dart';

class UserItemView extends StatelessWidget {
  const UserItemView({
    super.key,
    required this.user,
  });
  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        GoRouter.of(context).pushNamed(ChatScreen.path, extra: user);
      },
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FadeInImage(
          placeholder: const AssetImage(AssetConstants.placeholderImage),
          image: NetworkImage(user.photo),
          fit: BoxFit.cover,
          width: 35.0, // Set the image width
          height: 35.0, // Set the image height
        ),
      ),
      title: Text(user.name, style: Theme.of(context).textTheme.bodyMedium),
      subtitle: Text(user.email, style: Theme.of(context).textTheme.bodySmall),
    );
  }
}
