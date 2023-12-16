import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';

class UserDashboardView extends StatefulWidget {
  const UserDashboardView({Key? key}) : super(key: key);

  Widget build(context, UserDashboardController controller) {
    controller.view = this;
    return Scaffold(
      appBar: AppBar(
        title: const Text("UserDashboard"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: RealmCounter(
                      stream: TaskService.instance.snapshot(),
                      itemBuilder: (items) {
                        return QStatistic(
                          label: "Total",
                          value: items.length,
                          icon: Icons.task,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: RealmCounter(
                      stream: TaskService.instance.snapshot(
                        query: "status == 'Pending'",
                      ),
                      itemBuilder: (items) {
                        return QStatistic(
                          label: "Pending",
                          value: items.length,
                          icon: Icons.task,
                          color: warningColor,
                        );
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: RealmCounter(
                      stream: TaskService.instance.snapshot(
                        query: "status == 'Ongoing'",
                      ),
                      itemBuilder: (items) {
                        return QStatistic(
                          label: "Ongoing",
                          value: items.length,
                          icon: Icons.task,
                          color: infoColor,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: RealmCounter(
                      stream: TaskService.instance.snapshot(
                        query: "status == 'Review'",
                      ),
                      itemBuilder: (items) {
                        return QStatistic(
                          label: "Review",
                          value: items.length,
                          icon: Icons.task,
                          color: secondaryColor,
                        );
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: RealmCounter(
                      stream: TaskService.instance.snapshot(
                        query: "status == 'Done'",
                      ),
                      itemBuilder: (items) {
                        return QStatistic(
                          label: "Done",
                          value: items.length,
                          icon: Icons.task,
                          color: successColor,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<UserDashboardView> createState() => UserDashboardController();
}
