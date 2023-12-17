import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

class AdminTaskFormView extends StatefulWidget {
  final Task? item;
  const AdminTaskFormView({
    Key? key,
    this.item,
  }) : super(key: key);

  Widget build(context, AdminTaskFormController controller) {
    controller.view = this;
    return Scaffold(
      appBar: AppBar(
        title: const Text("AdminTaskForm"),
        actions: const [],
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
                    {
                      "label": "Done",
                      "value": "Done",
                    },
                  ],
                  value: controller.status,
                  onChanged: (value, label) {
                    controller.status = value;
                  },
                ),
                RealmListView<UserProfile>(
                  stream: UserProfileService.instance.snapshot(),
                  itemsBuilder: (items) {
                    return QDropdownField(
                      label: "Assigned To",
                      validator: Validator.required,
                      items: items.map((e) {
                        return {
                          "label": e!.name,
                          "value": e,
                        };
                      }).toList(),
                      value: controller.assignedTo,
                      onChanged: (value, label) {
                        controller.assignedTo = value;
                      },
                    );
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
  State<AdminTaskFormView> createState() => AdminTaskFormController();
}
