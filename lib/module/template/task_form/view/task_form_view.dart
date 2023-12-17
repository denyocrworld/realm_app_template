import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

class HUITemplateFormView extends StatefulWidget {
  final Task? item;
  const HUITemplateFormView({
    Key? key,
    this.item,
  }) : super(key: key);

  Widget build(context, HUITemplateFormController controller) {
    controller.view = this;
    return Scaffold(
      appBar: AppBar(
        title: const Text("HUITemplate Form"),
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
  State<HUITemplateFormView> createState() => HUITemplateFormController();
}
