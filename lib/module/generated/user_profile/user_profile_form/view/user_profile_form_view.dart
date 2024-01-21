import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

class UserProfileFormView extends StatefulWidget {
  final UserProfile? item;
  const UserProfileFormView({
    Key? key,
    this.item,
  }) : super(key: key);

  Widget build(context, UserProfileFormController controller) {
    controller.view = this;
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile Form"),
        actions: const [],
      ),
      body: FormColumn(
        formKey: controller.formKey,
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
            validator: Validator.required,
            value: controller.email,
            onChanged: (value) {
              controller.email = value;
            },
          ),
          QTextField(
            label: "Password",
            validator: Validator.required,
            value: controller.password,
            onChanged: (value) {
              controller.password = value;
            },
          ),
          QTextField(
            label: "Role",
            validator: Validator.required,
            value: controller.role,
            onChanged: (value) {
              controller.role = value;
            },
          ),
          QImagePicker(
            label: "Photo",
            validator: Validator.required,
            value: controller.photo,
            onChanged: (value) {
              controller.photo = value;
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
  State<UserProfileFormView> createState() => UserProfileFormController();
}
