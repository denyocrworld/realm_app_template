import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

class ProductFormView extends StatefulWidget {
  final Product? item;
  const ProductFormView({
    Key? key,
    this.item,
  }) : super(key: key);

  Widget build(context, ProductFormController controller) {
    controller.view = this;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Form"),
        actions: const [],
      ),
      body: FormColumn(
        formKey: controller.formKey,
        children: [
          QImagePicker(
            label: "Photo",
            validator: Validator.required,
            value: controller.photo,
            onChanged: (value) {
              controller.photo = value;
            },
          ),
          QTextField(
            label: "Product Name",
            validator: Validator.required,
            value: controller.productName,
            onChanged: (value) {
              controller.productName = value;
            },
          ),
          QNumberField(
            label: "Price",
            validator: Validator.required,
            value: controller.price?.toString(),
            onChanged: (value) {
              controller.price = double.tryParse(value) ?? 0;
            },
          ),
          QNumberField(
            label: "Stock",
            validator: Validator.required,
            value: controller.stock?.toString(),
            onChanged: (value) {
              controller.stock = double.tryParse(value) ?? 0;
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
        ],
      ),
      bottomNavigationBar: QActionButton(
        label: "Save",
        onPressed: () => controller.save(),
      ),
    );
  }

  @override
  State<ProductFormView> createState() => ProductFormController();
}
