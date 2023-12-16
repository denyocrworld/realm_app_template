import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

class UserTaskFormView extends StatefulWidget {
  final Task? item;
  UserTaskFormView({
    Key? key,
    this.item,
  }) : super(key: key);

  Widget build(context, UserTaskFormController controller) {
    controller.view = this;
    return Scaffold(
      appBar: AppBar(
        title: Text("UserTaskForm"),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: controller.formKey,
            child: Column(
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
                    if (isAdmin) ...[
                      {
                        "label": "Done",
                        "value": "Done",
                      },
                    ],
                  ],
                  value: controller.status,
                  onChanged: (value, label) {
                    controller.status = value;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: QActionButton(
        label: "Save",
        onPressed: () => controller.save(),
      ),
    );
  }

  @override
  State<UserTaskFormView> createState() => UserTaskFormController();
}
