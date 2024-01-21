import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';

class AdminMainNavigationView extends StatefulWidget {
  const AdminMainNavigationView({Key? key}) : super(key: key);

  Widget build(context, AdminMainNavigationController controller) {
    controller.view = this;

    return QNavigation(
      mode: QNavigationMode.nav2,
      pages: [
        AdminDashboardView(),
        AdminTaskListView(),
        AdminUserListView(),
        AdminProfileView(),
      ],
      menus: [
        NavigationMenu(
          icon: Icons.dashboard,
          label: "Dashboard",
        ),
        NavigationMenu(
          icon: Icons.list,
          label: "Tasks",
        ),
        NavigationMenu(
          icon: Icons.people,
          label: "Users",
        ),
        NavigationMenu(
          icon: Icons.person,
          label: "Profile",
        ),
      ],
    );
  }

  @override
  State<AdminMainNavigationView> createState() =>
      AdminMainNavigationController();
}
