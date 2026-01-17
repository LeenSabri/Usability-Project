import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'side_menu.dart';
import 'app_bar.dart';
import './api/api_config.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final double buttonWidth = 110.0;
  List<dynamic> _notifications = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
  }

  Future<void> _fetchNotifications() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/notifications'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _notifications = jsonDecode(response.body);
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Error fetching notifications: $e");
      setState(() => _isLoading = false);
    }
  }

  Future<void> _markAsRead(int notificationId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      final response = await http.patch(
        Uri.parse('${ApiConfig.baseUrl}/notifications/read/$notificationId'),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        setState(() {
          final index = _notifications.indexWhere(
            (n) => n['notification_id'] == notificationId,
          );
          if (index != -1) {
            _notifications[index]['is_read'] = true;
          }
        });
      }
    } catch (e) {
      debugPrint("Error marking as read: $e");
    }
  }

  Future<void> _softDeleteNotification(int id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      await http.delete(
        Uri.parse('${ApiConfig.baseUrl}/notifications/$id'),
        headers: {"Authorization": "Bearer $token"},
      );
    } catch (e) {
      debugPrint("Error deleting notification: $e");
    }
  }

  Future<void> _unblockNotification(int notificationId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      final response = await http.patch(
        Uri.parse('${ApiConfig.baseUrl}/notifications/unblock/$notificationId'),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Conversation unblocked successfully"),
            ),
          );
        }
        _fetchNotifications();
      }
    } catch (e) {
      debugPrint("Error unblocking: $e");
    }
  }

  Future<bool> _confirmDelete() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Delete Notification"),
            content: const Text(
              "Are you sure you want to remove this notification?",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Yes"),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E2D2),
      drawer: const SideMenu(),
      appBar: const CustomAppBar(title: "Notifications"),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.green))
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: _notifications.isEmpty
                  ? const Center(child: Text("No notifications found"))
                  : ListView.builder(
                      itemCount: _notifications.length,
                      itemBuilder: (context, index) {
                        final notif = _notifications[index];
                        final id = notif['notification_id'];

                        return Dismissible(
                          key: ValueKey(id),
                          direction: DismissDirection.startToEnd,
                          confirmDismiss: (_) => _confirmDelete(),
                          background: Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 20),
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          onDismissed: (_) async {
                            setState(() {
                              _notifications.removeAt(index);
                            });
                            await _softDeleteNotification(id);
                          },
                          child: _buildNotificationCard(notif),
                        );
                      },
                    ),
            ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notif) {
    String childName = notif['child_name'] ?? "Child Name";
    String status = notif['status'] ?? "blocked";
    bool isRead = notif['is_read'] ?? false;

    return InkWell(
      onTap: () {
        _markAsRead(notif['notification_id']);
        _showViewAlert(notif);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: (isRead || status == "unblocked")
              ? Colors.white
              : const Color(0xFFD6E6D1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    childName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const Text(
                    "We have blocked a message for your child in Luanti",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, size: 30, color: Color(0xFF2E7D32)),
          ],
        ),
      ),
    );
  }

  void _showViewAlert(Map<String, dynamic> notif) {
    String childName = notif['child_name'] ?? "Your Child";
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.account_circle,
              size: 80,
              color: Color(0xFF2E7D32),
            ),
            Text(
              childName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const Text(
              "We have blocked a message in luanti\nthat posed a potential risk.",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Reason: ${notif['reason'] ?? 'Sensitive Content'}",
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Another player asked $childName to share private information.",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (notif['status'] == 'blocked')
                  _buildUnifiedButton("Unblock", Colors.red, Colors.white, () {
                    Navigator.pop(context);
                    _showUnblockConfirm(notif);
                  }),
                const SizedBox(width: 10),
                _buildUnifiedButton(
                  "View",
                  const Color(0xFFF9C846),
                  Colors.black,
                  () {
                    Navigator.pop(context);
                    _showDisplayMessage(notif);
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            _buildUnifiedButton("Close", Colors.grey[400]!, Colors.black, () {
              Navigator.pop(context);
            }, width: buttonWidth * 2 + 10),
          ],
        ),
      ),
    );
  }

  void _showDisplayMessage(Map<String, dynamic> notif) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "The Message",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFFD6E6D1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                notif['message_content'] ?? "No content available",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildUnifiedButton(
                  "Back",
                  const Color(0xFFF9C846),
                  Colors.black,
                  () {
                    Navigator.pop(context);
                    _showViewAlert(notif);
                  },
                ),
                const SizedBox(width: 10),
                _buildUnifiedButton(
                  "Close",
                  Colors.grey[400]!,
                  Colors.black,
                  () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showUnblockConfirm(Map<String, dynamic> notif) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Column(
          children: [
            Icon(Icons.warning_amber_rounded, size: 60, color: Colors.red),
            Text(
              "Confirm Unblock",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
          ],
        ),
        content: const Text(
          "Confirm that this conversation is not dangerous for your child?",
          textAlign: TextAlign.center,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildUnifiedButton("Yes", Colors.red, Colors.white, () {
                Navigator.pop(context);
                _unblockNotification(notif['notification_id']);
              }),
              const SizedBox(width: 10),
              _buildUnifiedButton(
                "No",
                const Color(0xFFF9C846),
                Colors.black,
                () {
                  Navigator.pop(context);
                  _showViewAlert(notif);
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildUnifiedButton(
    String text,
    Color bgColor,
    Color textColor,
    VoidCallback onPressed, {
    double? width,
  }) {
    return SizedBox(
      width: width ?? buttonWidth,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 10),
        ),
        child: Text(
          text,
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
