import 'package:flutter/material.dart';
import 'side_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          "Home",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          const Icon(Icons.account_circle, color: Colors.white, size: 35),
          const SizedBox(width: 15),
          const Icon(Icons.notifications, color: Colors.white, size: 30),
          const SizedBox(width: 15),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: [
            _buildHomeButton(Icons.person, "Parent Profile"),
            _buildHomeButton(Icons.accessibility_new, "Children Information"),
            _buildHomeButton(Icons.group_add, "Link Child"),
            _buildHomeButton(Icons.notifications_active, "Notifications"),
            _buildHomeButton(Icons.exit_to_app, "Log Out"),
            _buildHomeButton(Icons.info, "About Us"),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeButton(IconData icon, String label) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFD6E6D1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF2E7D32), width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: const Color(0xFF2E7D32)),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32),
            ),
          ),
        ],
      ),
    );
  }
}
