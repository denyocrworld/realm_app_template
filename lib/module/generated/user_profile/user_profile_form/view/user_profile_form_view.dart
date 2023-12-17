import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

class TaskFormView extends StatefulWidget {
  final Task? item;
  const TaskFormView({
    Key? key,
    this.item,
  }) : super(key: key);

  Widget build(context, TaskFormController controller) {
    controller.view = this;
    return Scaffold(
      appBar: AppBar(
        title: const Text("TaskForm"),
        actions: const [],
      ),
      body: FormColumn(
        key: controller.formKey,
        children: [
          QTextField(
            label: "Task name",
            validator: Validator.required,
            value: controller.taskName,
            onChanged: (value) {
              controller.taskName = value;
            },
          ),
          QMemoField(
            label: "Description",
            validator: Validator.required,
            value: controller.description,
            onChanged: (value) {
              controller.description = value;
            },
          ),
          QDropdownField(
            label: "Status",
            validator: Validator.required,
            items: ds.status,
            value: controller.status,
            onChanged: (value, label) {
              controller.status = value;
            },
          ),
          UserProfileDropdownField(
            label: "Assigned To",
            validator: Validator.required,
            value: controller.assignedTo,
            onChanged: (value, label) {
              controller.assignedTo = value;
            },
          ),
        ],
      ),
      bottomNavigationBar: QActionButton(
        label: "Save",
        onPressed: () => controller.save(),
      ),
    );
  }

  @override
  State<TaskFormView> createState() => TaskFormController();
}
