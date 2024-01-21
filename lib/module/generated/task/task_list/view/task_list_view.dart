import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';
import 'package:realm_app/shared/widget/realm/realm_search.dart';

class TaskListView extends StatefulWidget {
  TaskListView({Key? key}) : super(key: key);

  Widget build(context, TaskListController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: Text("Task List"),
        actions: [
          RealmDelete(TaskService.instance),
          RealmSearch(
            value: controller.search,
            onSearch: (value) => controller.updateSearch(value),
          ),
        ],
      ),
      body: Column(
        children: [
          //@STATUS_FILTER
          QCategoryPicker(
            items: ds.status,
            value: controller.status,
            validator: Validator.required,
            onChanged: (index, label, value, item) {
              controller.updateStatus(value);
            },
          ),
          //@:STATUS_FILTER
          Expanded(
            child: RealmListView<Task>(
              stream: TaskService.instance
                  .snapshot(query: "status == '${controller.status}'"),
              padding: EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              itemBuilder: (item, index) {
                bool searchCondition = item.taskName!
                    .toLowerCase()
                    .contains(controller.search.toLowerCase());
                if (controller.search.isNotEmpty && !searchCondition) {
                  return SizedBox.shrink();
                }

                return QDismissible(
                  onDismiss: () => controller.delete(item),
                  child: ListTile(
                    title: Text(item.taskName ?? "-"),
                    subtitle: Text(item.description ?? "-"),
                    onTap: () => Get.to(TaskFormView(item: item)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingAction(
        onPressed: () async {
          await Get.to(TaskFormView());
        },
      ),
    );
  }

  @override
  State<TaskListView> createState() => TaskListController();
}
