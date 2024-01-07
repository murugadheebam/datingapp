import 'package:flutter/material.dart';

class Notificationpage extends StatefulWidget {
  @override
  _NotificationpageState createState() => _NotificationpageState();
}

class _NotificationpageState extends State<Notificationpage> {
  final List<NotificationItem> notifications = [
    NotificationItem(
      senderName: 'Nira Manisha',
      message: 'Sent you a Connection Request',
      date: 'Just now',
      isRead: true,
    ),
    NotificationItem(
      senderName: 'Nira Manisha add 1',
      message: 'Sent you a Connection Request',
      date: 'Just now',
      isRead: false,
    ),
    // ... add other notifications
  ];

  List<NotificationItem> unreadNotifications =
      []; // Initialize unread notifications list

  @override
  void initState() {
    super.initState();
    // Set unreadNotifications initially based on notifications' unread status
    unreadNotifications = notifications.where((n) => !n.isRead).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Notification',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.black87,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {},
          ),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Align buttons to the left
              children: [
                SizedBox(width: 10), // Space between buttons

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      unreadNotifications = notifications;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.grey[200]!,
                    ),
                    foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.red,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  child: Text('All'),
                ),
                SizedBox(width: 10), // Space between buttons

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      unreadNotifications =
                          notifications.where((n) => !n.isRead).toList();
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.grey[200]!,
                    ),
                    foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.red,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  child: Text('Unread'),
                ),
              ],
            ),
            Visibility(
              visible: unreadNotifications.isNotEmpty,
              child: Expanded(
                child: ListView.builder(
                  itemCount: unreadNotifications.length,
                  itemBuilder: (context, index) {
                    final item = unreadNotifications[index];
                    return buildNotificationTile(item);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNotificationTile(NotificationItem item) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 8.0), // Adjust the vertical space between tiles
      child: Container(
        decoration: BoxDecoration(
          color: item.isRead
              ? Colors.white
              : Colors.grey[200], // Background color for unread notifications
          borderRadius:
              BorderRadius.circular(12.0), // Border radius for the container
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/profile3.png'),
          ),
          title: Text(
            '${item.senderName} ${item.message}',
            style: TextStyle(
              fontWeight: !item.isRead ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          subtitle: Text(item.date),
          trailing: item.isRead
              ? null
              : Icon(Icons.circle, color: Colors.red, size: 12.0),
        ),
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
