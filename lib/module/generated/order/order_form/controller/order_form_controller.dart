import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

class OrderFormController extends State<OrderFormView> {
  static late OrderFormController instance;
  late OrderFormView view;

  @override
  void initState() {
    instance = this;
    if (isEditMode) {
      createdBy = current!.createdBy;
      createdAt = current!.createdAt;
      customerName = current!.customerName;
      items = current!.items;
      total = current!.total;
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

  Order? get current => widget.item;
  bool get isEditMode => current != null;
  bool get isCreateMode => current == null;

  UserProfile? createdBy;
  DateTime? createdAt;
  String? customerName;
  List<Product>? items = [];
  double? total;

  save() {
    if (isNotValid) return;
    if (isCreateMode) create();
    if (isEditMode) update();
  }

  create() {
    showLoading();
    OrderService.instance.add(
      Order(
        ObjectId(),
        createdBy: userProfile,
        createdAt: DateTime.now(),
        customerName: customerName,
        items: items,
        total: total,
      ),
    );
    hideLoading();
    Get.back();
    ss("Data created");
  }

  update() {
    showLoading();
    OrderService.instance.update(
      id: current!.id,
      update: (item) {
        item.createdBy = createdBy;
        item.createdAt = createdAt;
        item.customerName = customerName;
        item.items = items.toList() as RealmList<Product>;
        item.total = total;
      },
    );
    hideLoading();
    Get.back();
    ss("Data updated");
  }
}
