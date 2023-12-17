import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

class AdminTaskListView extends StatefulWidget {
  AdminTaskListView({Key? key}) : super(key: key);

  Widget build(context, AdminTaskListController controller) {
    controller.view = this;
    return Scaffold(
      appBar: AppBar(
        title: Text("AdminTaskList"),
        actions: [
          if (kDebugMode)
            IconButton(
              onPressed: () {
                TaskService.instance.deleteAll();
              },
              icon: Icon(
                Icons.delete_forever,
                size: 24.0,
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          QCategoryPicker(
            items: [
              {
                "label": "Pending",
                "value": "Pending",
              },
              {
                "label": "Ongoing",
                "value": "Ongoing",
              },
              {
                "label": "Review",
                "value": "Review",
              },
              {
                "label": "Done",
                "value": "Done",
              }
            ],
            value: controller.status,
            validator: Validator.required,
            onChanged: (index, label, value, item) {
              controller.updateStatus(value);
            },
          ),
          Expanded(
            child: RealmListView<Task>(
              stream: TaskService.instance
                  .snapshot(query: "status == '${controller.status}'"),
              padding: EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              itemBuilder: (item, index) {
                return QDismissible(
                  onDismiss: () => controller.delete(item),
                  child: InkWell(
                    onTap: () async {
                      await Get.to(AdminTaskFormView(
                        item: item,
                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: 12.0,
                      ),
                      child: Card(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Created At: ${item.createdAt?.dMMMykkss}",
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.taskName ?? "-",
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          item.description ?? "-",
                                          style: TextStyle(
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    item.status ?? "-",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: secondaryColor.withOpacity(0.6),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12.0),
                                  bottomRight: Radius.circular(12.0),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Created by: ${item.createdBy?.name}",
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        heroTag: Key("${Random().nextInt(10000)}"),
        onPressed: () async {
          await Get.to(AdminTaskFormView());
        },
      ),
    );
  }

  @override
  State<AdminTaskListView> createState() => AdminTaskListController();
}
