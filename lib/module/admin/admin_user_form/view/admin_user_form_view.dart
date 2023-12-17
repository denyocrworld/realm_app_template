import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

class AdminUserFormView extends StatefulWidget {
  final UserProfile? item;
  AdminUserFormView({
    Key? key,
    this.item,
  }) : super(key: key);

  Widget build(context, AdminUserFormController controller) {
    controller.view = this;
    return Scaffold(
      appBar: AppBar(
        title: Text("AdminUserForm"),
        actions: [],
      ),
      body: Form(
        key: controller.formKey,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              QTextField(
                label: "Name",
                validator: Validator.required,
                value: controller.name,
                onChanged: (value) {
                  controller.name = value;
                },
              ),
              QTextField(
                label: "Email",
                validator: Validator.email,
                suffixIcon: Icons.email,
                value: controller.email,
                enabled: !controller.isEditMode,
                onChanged: (value) {
                  controller.email = value;
                },
              ),
              QTextField(
                label: "Password",
                obscure: true,
                validator: Validator.required,
                suffixIcon: Icons.password,
                value: controller.password,
                enabled: !controller.isEditMode,
                onChanged: (value) {
                  controller.password = value;
                },
              ),
              QDropdownField(
                label: "Role",
                validator: Validator.required,
                items: ds.roles,
                value: controller.role,
                onChanged: (value, label) {
                  controller.role = value;
                },
              ),
            ],
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
  State<AdminUserFormView> createState() => AdminUserFormController();
}
