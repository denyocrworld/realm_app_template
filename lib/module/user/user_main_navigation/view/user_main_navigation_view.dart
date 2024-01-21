import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';

class UserMainNavigationView extends StatefulWidget {
  const UserMainNavigationView({Key? key}) : super(key: key);

  Widget build(context, UserMainNavigationController controller) {
    controller.view = this;
    return QNavigation(
      mode: QNavigationMode.nav2,
      pages: [
        UserDashboardView(),
        UserTaskListView(),
        UserProfileView(),
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
          icon: Icons.person,
          label: "Profile",
        ),
      ],
    );
  }

  @override
  State<UserMainNavigationView> createState() => UserMainNavigationController();
}
