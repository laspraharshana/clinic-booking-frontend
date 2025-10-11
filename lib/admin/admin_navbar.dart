import 'package:flutter/material.dart';
import 'admin_dashbord.dart';
import 'reports_page.dart';

class ABottomNavBar extends StatelessWidget {
  final int selectedIndex;

  const ABottomNavBar({super.key, required this.selectedIndex});

  void _onBottomNavTapped(BuildContext context, int index) {
    // Don't navigate if already on the selected page
    if (index == selectedIndex) return;

    Widget page;
    switch (index) {
      case 0:
        page = const AdminDashboard();
        break;
      // case 1:
      //   page = const AllDoctorsPage();
      //   break;
      // case 2:
      //   page = const PlaceholderPage(title: "Add New Page");
      //   break;
      case 3:
        page = const AdminReportsPage();
        break;
      // case 4:
      //    page = const PatientProfilePage();
      //   break;
      //  case 5:
      //    page = const AdminSetting();
      //   break;
      default:
        return;
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(context, Icons.dashboard_outlined, "Dashbord", 0),
          _buildNavItem(context, Icons.people_outline, "Doctors", 1),
          _buildNavItem(
            context,
            Icons.calendar_today_outlined,
            "Appoinments",
            2,
          ),
          _buildNavItem(context, Icons.bar_chart_outlined, "Reports", 3),
          _buildNavItem(context, Icons.settings_outlined, "Settings", 4),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    int index,
  ) {
    final bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => _onBottomNavTapped(context, index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        decoration: isSelected
            ? BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(20),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF1B5E57) : Colors.grey,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? const Color(0xFF1B5E57) : Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            if (isSelected)
              Container(
                width: 5,
                height: 5,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF1B5E57),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
