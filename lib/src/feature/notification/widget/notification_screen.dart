import 'package:auto_route/annotations.dart';
import 'package:employee_management/src/core/utils/extensions/context_extension.dart';
import 'package:employee_management/src/feature/notification/model/notification.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel> notifications = const [
    NotificationModel('Schedule Updated', '2nd Oct 2024'),
    NotificationModel('Tomorrow is holiday', '28th Sep 2024'),
    NotificationModel('Meeting At 10:00 AM', '20th Sep 2024'),
    NotificationModel('Schedule Updated', '12th Sep 2024'),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: const Text(
            'Notification',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Roboto',
            ),
          ),
          surfaceTintColor: Colors.transparent,
        ),
        body: ListView.separated(
          itemBuilder: (_, index) => ListTile(
            onTap: () async {
              await showModalBottomSheet<NotificationModel>(
                context: context,
                constraints: BoxConstraints(
                  maxHeight: context.height * 0.5,
                ),
                builder: (context) => Padding(
                  padding:
                      EdgeInsets.fromLTRB(24, 24, 24, context.bottomPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Center(
                            child: Text('Notification Details'),
                          ),
                          const SizedBox(height: 16),
                          Text('Title: ${notifications[index].title}'),
                          Text('Date: ${notifications[index].dateTime}'),
                        ],
                      ),
                      Column(
                        children: [
                          ShadButton(
                            width: double.infinity,
                            child: const Text('Close'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          SizedBox(
                            height: context.bottomPadding,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            dense: true,
            leading: const Icon(Icons.notifications_none),
            title: Text(notifications[index].title),
            subtitle: Text(notifications[index].dateTime),
          ),
          separatorBuilder: (_, __) => const Divider(height: 0),
          itemCount: notifications.length,
        ),
      );
}
