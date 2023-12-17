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
        title: const Text("Task Form"),
        actions: const [],
      ),
      body: FormColumn(
        key: controller.formKey,
        children: [
          //@FORM
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
