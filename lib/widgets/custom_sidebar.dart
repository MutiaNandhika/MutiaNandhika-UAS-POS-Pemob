import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/controllers/AuthController.dart';

class CustomDrawer extends StatelessWidget {
  final int selectedIndex;

  const CustomDrawer({super.key, this.selectedIndex = 0});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Drawer(
      child: Container(
        color: Colors.pink,
        child: Column(
          children: [
            // Drawer Header
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.purple),
              child: const Center(
                child: Text(
                  'Sistem Point of Sale',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Navigation Items
            _buildNavItem(
              icon: Icons.dashboard,
              title: 'Dashboard',
              index: 0,
              selectedIndex: selectedIndex,
              onTap: () => _navigateTo(context, '/dashboard'),
            ),
            _buildNavItem(
              icon: Icons.point_of_sale,
              title: 'Cashier',
              index: 1,
              selectedIndex: selectedIndex,
              onTap: () => _navigateTo(context, '/cashier'),
            ),
            const Spacer(),

            // Logout Button
            _buildNavItem(
              icon: Icons.logout,
              title: 'Logout',
              index: -1,
              selectedIndex: selectedIndex,
              onTap: () {
                authController.logout();
                Navigator.pop(context); // Close the drawer
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// Navigation item builder
  Widget _buildNavItem({
    required IconData icon,
    required String title,
    required int index,
    required int selectedIndex,
    required VoidCallback onTap,
  }) {
    return Container(
      color: selectedIndex == index ? Colors.purple : Colors.transparent,
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        onTap: onTap,
      ),
    );
  }

  /// Navigation handler with route validation
  void _navigateTo(BuildContext context, String route) {
    if (Get.currentRoute != route) {
      Get.offAllNamed(route);
    }
    Navigator.pop(context); // Close the drawer
  }
}