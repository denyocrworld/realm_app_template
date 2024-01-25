import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

class ProductFormController extends State<ProductFormView> {
  static late ProductFormController instance;
  late ProductFormView view;

  @override
  void initState() {
    instance = this;
    if (isEditMode) {
      createdBy = current!.createdBy;
      photo = current!.photo;
      productName = current!.productName;
      price = current!.price;
      stock = current!.stock;
      description = current!.description;
    }
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool loading = false;

  bool get isNotValid {
    bool isValid = formKey.currentState!.validate();
    return !isValid;
  }

  bool get isValid {
    bool isValid = formKey.currentState!.validate();
    return isValid;
  }

  Product? get current => widget.item;
  bool get isEditMode => current != null;
  bool get isCreateMode => current == null;

  UserProfile? createdBy;
  String? photo;
  String? productName;
  double? price;
  double? stock;
  String? description;

  save() {
    if (isNotValid) return;
    if (isCreateMode) create();
    if (isEditMode) update();
  }

  create() {
    showLoading();
    ProductService.instance.add(
      Product(
        ObjectId(),
        createdBy: userProfile,
        photo: photo,
        productName: productName,
        price: price,
        stock: stock,
        description: description,
      ),
    );
    hideLoading();
    Get.back();
    ss("Data created");
  }

  update() {
    showLoading();
    ProductService.instance.update(
      id: current!.id,
      update: (item) {
        item.createdBy = createdBy;
        item.photo = photo;
        item.productName = productName;
        item.price = price;
        item.stock = stock;
        item.description = description;
      },
    );
    hideLoading();
    Get.back();
    ss("Data updated");
  }
}
