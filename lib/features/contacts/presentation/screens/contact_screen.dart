import 'package:chat_app/features/app_user/presentation/widgets/app_user_info_view.dart';
import 'package:chat_app/features/contacts/application/contact_provider.dart';
import 'package:chat_app/features/contacts/domain/entities/contact_list.dart';
import 'package:chat_app/features/contacts/presentation/widgets/user_item_view.dart';
import 'package:chat_app/features/push_notification/domain/entities/push_notification.dart';
import 'package:chat_app/features/push_notification/domain/repositories/push_notification_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/service_locator/service_locator.dart';
import '../../../app_user/domain/entities/user.dart';

class ContactScreen extends ConsumerStatefulWidget {
  const ContactScreen({super.key});
  static const String path = "contactScreen";
  @override
  ConsumerState<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends ConsumerState<ContactScreen> {
  @override
  void initState() {
    super.initState();
    _fetchContacts();
    _setupPushNotificationReceiver();
  }

  void _setupPushNotificationReceiver() {
    sl<PushNotificationRepository>().initializePushNotification();
    FirebaseMessaging.onMessage.listen((event) {
      PushNotification notification = PushNotification(
          title: event.notification?.title ?? "",
          body: event.notification?.body ?? "");
      sl<PushNotificationRepository>().onNotificationReceived(notification);
    });
  }

  Future<void> _fetchContacts() async {
    ref.read(contactsProvider.notifier).fetchContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            const AppUserInfoView(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _fetchContacts,
                child: _buildContactsListBody(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactsListBody() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getContactsLabel(),
            Expanded(
              child: _buildContactsList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getContactsLabel() {
    return Text("My Contacts", style: Theme.of(context).textTheme.titleMedium);
  }

  Widget _buildContactsList() {
    AsyncValue<ContactList> contacts = ref.watch(contactsProvider);
    return contacts.when(
        data: (ContactList contacts) {
          return _getContactListView(contacts);
        },
        error: (e, s) {
          return Center(
            child: Text(
              e.toString(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        },
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }

  Widget _getContactListView(ContactList contacts) {
    return ListView.separated(
      itemCount: contacts.users.length,
      itemBuilder: (BuildContext context, int index) {
        User user = contacts.users[index];

        return UserItemView(
          user: user,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Theme.of(context).dividerColor,
          thickness: 0.5,
        );
      },
    );
  }
}
