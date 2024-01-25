import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

class OrderFormView extends StatefulWidget {
  final Order? item;
  const OrderFormView({
    Key? key,
    this.item,
  }) : super(key: key);

  Widget build(context, OrderFormController controller) {
    controller.view = this;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Form"),
        actions: const [],
      ),
      body: FormColumn(
        formKey: controller.formKey,
        children: [
          QTextField(
            label: "Customer Name",
            validator: Validator.required,
            value: controller.customerName,
            onChanged: (value) {
              controller.customerName = value;
            },
          ),
          QNumberField(
            label: "Total",
            validator: Validator.required,
            value: controller.total?.toString(),
            onChanged: (value) {
              controller.total = double.tryParse(value) ?? 0;
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
  State<OrderFormView> createState() => OrderFormController();
}
