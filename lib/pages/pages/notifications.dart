import 'package:flutter/material.dart';

class Notification extends StatelessWidget {
  final List<NotificationItem> notifications = [
    NotificationItem(
      senderName: 'Nira Manisha',
      message: 'Sent you a Connection Request',
      date: 'Just now',
      isRead: false,
    ),
    NotificationItem(
      senderName: 'Nira Manisha add 1',
      message: 'Sent you a Connection Request',
      date: 'Just now',
      isRead: false,
    ),
    // ... add other notifications
  ];

  @override
  Widget build(BuildContext context) {
    List<NotificationItem> unreadNotifications =
        notifications.where((n) => !n.isRead).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
        bottom: TabBar(
          tabs: [
            Tab(text: 'All'),
            Tab(text: 'Unread'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final item = notifications[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/user_avatar.png'), // Replace with your asset image
                ),
                title: Text(
                  '${item.senderName} ${item.message}',
                  style: TextStyle(
                    fontWeight:
                        !item.isRead ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                subtitle: Text(item.date),
                trailing: item.isRead
                    ? null
                    : Icon(Icons.circle, color: Colors.red, size: 12.0),
              );
            },
          ),
          ListView.builder(
            itemCount: unreadNotifications.length,
            itemBuilder: (context, index) {
              final item = unreadNotifications[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/user_avatar.png'),
                ),
                title: Text(
                  '${item.senderName} ${item.message}',
                  style: TextStyle(
                    fontWeight:
                        !item.isRead ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                subtitle: Text(item.date),
                trailing: item.isRead
                    ? null
                    : Icon(Icons.circle, color: Colors.red, size: 12.0),
              );
            },
          ),
        ],
      ),
    );
  }
}

class NotificationItem {
  final String senderName;
  final String message;
  final String date;
  final bool isRead;

  NotificationItem({
    required this.senderName,
    required this.message,
    required this.date,
    this.isRead = true,
  });
}
