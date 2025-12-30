import 'package:flutter/material.dart';
import 'children_information_screen.dart';
import 'about_us_screen.dart';
import 'link_child_screen.dart';
import 'notifications_screen.dart';
import 'main.dart';
import 'profile_screen.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFFF5F1E6),
        child: Column(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              color: const Color(0xFF2E7D32),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20, top: 40),
              child: const Row(
                children: [
                  Icon(Icons.menu, color: Colors.white, size: 30),
                  SizedBox(width: 15),
                  Text(
                    "Home",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildItem(
                    context,
                    Icons.home,
                    "Home Page",
                    isSelected: true,
                  ),
                  _buildItem(
                    context,
                    Icons.account_circle,
                    "Parent Profile",
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilePage(),
                        ),
                      );
                    },
                  ),
                  _buildItem(
                    context,
                    Icons.accessibility_new,
                    "Children Information",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const ChildrenInformationScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    Icons.group_add,
                    "Link Child",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LinkChildScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    Icons.notifications,
                    "Notifications",
                    onTap: () {
                      Navigator.pop(context); 
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationsScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    Icons.info,
                    "About Us",
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AboutUsScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDrawerItem(Icons.exit_to_app, "Log Out", onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },),
                  ),
                  _buildItem(context, Icons.group_add, "Link Child"),
                  _buildItem(context, Icons.notifications, "Notifications"),
                  _buildItem(context, Icons.info, "About Us"),
                  _buildItem(context, Icons.exit_to_app, "Log Out"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    IconData icon,
    String title, {
    bool isSelected = false,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFD6E6D1) : Colors.transparent,
        border: const Border(
          bottom: BorderSide(color: Colors.black12, width: 0.5),
        ),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF2E7D32)),
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF2E7D32),
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: onTap ?? () => Navigator.pop(context),
      ),
    );
  }
}
