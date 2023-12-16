import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';

class UserMainNavigationView extends StatefulWidget {
  const UserMainNavigationView({Key? key}) : super(key: key);

  Widget build(context, UserMainNavigationController controller) {
    controller.view = this;
    return DefaultTabController(
      length: 3,
      initialIndex: controller.selectedIndex,
      child: Scaffold(
        body: IndexedStack(
          index: controller.selectedIndex,
          children: [
            UserDashboardView(),
            UserTaskListView(),
            UserProfileView(),
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
  State<UserMainNavigationView> createState() => UserMainNavigationController();
}
