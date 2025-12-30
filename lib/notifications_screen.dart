import 'package:flutter/material.dart';
import 'side_menu.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E2D2),
      drawer: const SideMenu(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32), 
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white, size: 30),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text(
          "Notification",
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          const Icon(Icons.account_circle, color: Colors.white, size: 35),
          const SizedBox(width: 15),
          const Icon(Icons.notifications, color: Colors.white, size: 30),
          const SizedBox(width: 15),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            _buildNotificationCard("Rawan Yahya"),
            _buildNotificationCard("Lana Zaben"),
            _buildNotificationCard("Leen Sabri"),
            _buildNotificationCard("Diaa Nawawreh"),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard(String childName) {
    return InkWell(
      onTap: () => _showViewAlert(childName),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFD6E6D1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              childName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Text(
              "We have blocked a message for your your child in Luanti",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  void _showViewAlert(String childName) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            const Icon(Icons.account_circle, size: 80, color: Color(0xFF2E7D32)),
            const Text("Samer", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const Text(
              "We have blocked a message in luanti\nthat posed a potential risk.",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Reason: Request to Share Personal Information",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Another player asked $childName to share private information (address of your child). This conversation was immediately blocked.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showUnblockConfirm(childName);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("Unblock", style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showDisplayMessage(childName);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF9C846)),
                  child: const Text("View Message", style: TextStyle(color: Colors.black)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showDisplayMessage(String childName) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "The Message",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2E7D32), fontSize: 18),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFFD6E6D1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Hi Rawan, Can you send me your location to visit you",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomLeft,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showViewAlert(childName);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF9C846),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("Back", style: TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showUnblockConfirm(String childName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Column(
          children: [
            Icon(Icons.account_circle, size: 60, color: Colors.grey),
            Text("Samer", style: TextStyle(fontSize: 14)),
            Text(
              "Unblock Conversation",
              style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
            ),
          ],
        ),
        content: const Text(
          "If you unblock this conversation, you are confirming that this conversation is not dangerous for your child",
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Yes", style: TextStyle(color: Colors.white)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showViewAlert(childName);
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF9C846)),
            child: const Text("No", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}