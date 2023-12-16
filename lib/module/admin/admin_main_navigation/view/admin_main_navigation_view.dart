import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';

class AdminMainNavigationView extends StatefulWidget {
  const AdminMainNavigationView({Key? key}) : super(key: key);

  Widget build(context, AdminMainNavigationController controller) {
    controller.view = this;

    return DefaultTabController(
      length: 4,
      initialIndex: controller.selectedIndex,
      child: Scaffold(
        body: IndexedStack(
          index: controller.selectedIndex,
          children: [
            AdminDashboardView(),
            AdminTaskListView(),
            AdminUserListView(),
            AdminProfileView(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex,
          onTap: (newIndex) => controller.updateIndex(newIndex),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.dashboard,
              ),
              label: "Dashboard",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
              ),
              label: "Tasks",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.people,
              ),
              label: "Users",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<AdminMainNavigationView> createState() =>
      AdminMainNavigationController();
}
