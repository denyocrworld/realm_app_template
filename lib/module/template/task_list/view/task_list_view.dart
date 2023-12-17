import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

class HUITemplateListView extends StatefulWidget {
  HUITemplateListView({Key? key}) : super(key: key);

  Widget build(context, HUITemplateListController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: Text("HUITemplate List"),
        actions: [
          RealmDelete(TaskService.instance),
        ],
      ),
      body: Column(
        children: [
          QCategoryPicker(
            items: ds.status,
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
                  child: ListTile(
                    title: Text(item.taskName ?? "-"),
                    subtitle: Text(item.description ?? "-"),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingAction(
        onPressed: () async {
          await Get.to(HUITemplateFormView());
        },
      ),
    );
  }

  @override
  State<HUITemplateListView> createState() => HUITemplateListController();
}
