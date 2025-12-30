import 'package:flutter/material.dart';
import 'children_information_screen.dart';
import 'about_us_screen.dart';
import 'link_child_screen.dart';
import 'notifications_screen.dart';
import 'main.dart';

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
              height: 100,
              width: double.infinity,
              color: const Color(0xFF2E7D32),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20, top: 30),
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
                  _buildDrawerItem(
                    Icons.home,
                    "Home Page",
                    isSelected: true,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  _buildDrawerItem(
                    Icons.account_circle,
                    "Parent Profile",
                    onTap: () {},
                  ),
                  _buildDrawerItem(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
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
            fontSize: 16,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
