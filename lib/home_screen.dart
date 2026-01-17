import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'side_menu.dart';
import 'children_information_screen.dart';
import 'link_child_screen.dart';
import 'notifications_screen.dart';
import 'about_us_screen.dart';
import 'profile_screen.dart';
import 'app_bar.dart';
import 'main.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E2D2),
      drawer: const SideMenu(),
      appBar: const CustomAppBar(title: "Home"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [

            _buildHomeButton(
              context,
              Icons.person,
              "Parent Profile",
              const ProfilePage(),
            ),
            _buildHomeButton(
              context,
              Icons.accessibility_new,
              "Children Information",
              const ChildrenInformationScreen(),
            ),
            _buildHomeButton(
              context,
              Icons.group_add,
              "Link Child",
              const LinkChildScreen(),
            ),
            _buildHomeButton(
              context,
              Icons.notifications_active,
              "Notifications",
              const NotificationsScreen(),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  _buildHomeButton(
                    context,
                    Icons.person,
                    "Parent Profile",
                    const ProfilePage(),
                  ),
                  _buildHomeButton(
                    context,
                    Icons.accessibility_new,
                    "Children Information",
                    const ChildrenInformationScreen(),
                  ),
                  _buildHomeButton(
                    context,
                    Icons.group_add,
                    "Link Child",
                    const LinkChildScreen(),
                  ),
                  _buildHomeButton(
                    context,
                    Icons.notifications_active,
                    "Notifications",
                    const NotificationsScreen(),
                  ),
                  _buildHomeButton(context, Icons.exit_to_app, "Log Out", null),
                  _buildHomeButton(
                    context,
                    Icons.info,
                    "About Us",
                    const AboutUsScreen(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeButton(
    BuildContext context,
    IconData icon,
    String label,
    Widget? destination,
  ) {

    return InkWell(
      onTap: () async {
        if (destination != null) {
          SideMenu.updateSelected(label);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        } else if (label == "Log Out") {
          final confirm = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Confirm Logout"),
              content: const Text("Are you sure you want to log out?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text("Log Out"),
                ),
              ],
            ),
          );

          if (confirm == true) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.clear();

            if (context.mounted) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            }
          }
        }
      },
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          color: label == "Log Out"
              ? const Color(0xFFFFE0E0)
              : const Color(0xFFD6E6D1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: label == "Log Out" ? Colors.red : const Color(0xFF2E7D32),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: label == "Log Out" ? Colors.red : const Color(0xFF2E7D32),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: label == "Log Out"
                    ? Colors.red
                    : const Color(0xFF2E7D32),
              ),
            ),
          ],
        ),
      ),
    );
  }
}