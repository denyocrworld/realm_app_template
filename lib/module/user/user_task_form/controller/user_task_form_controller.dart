import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

class UserTaskFormController extends State<UserTaskFormView> {
  static late UserTaskFormController instance;
  late UserTaskFormView view;

  @override
  void initState() {
    instance = this;
    loadCurrentData();
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool get isEditMode => widget.item != null;
  bool get isCreateMode => widget.item == null;

  String? taskName;
  String? description;
  String? status = "Pending";
  UserProfile? assignedTo;

  loadCurrentData() {
    if (!isEditMode) return;
    taskName = widget.item!.taskName;
    description = widget.item!.description;
    status = widget.item!.status;
    assignedTo = widget.item!.assignedTo;
  }

  save() {
    bool isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    if (isCreateMode) create();
    if (isEditMode) update();
  }

  create() {
    showLoading();
    TaskService.instance.add(
      Task(
        ObjectId(),
        createdAt: DateTime.now(),
        createdBy: userProfile,
        assignedTo: userProfile,
        taskName: taskName,
        description: description,
        status: status,
      ),
    );
    hideLoading();
    Get.back();
    ss("Data created");
  }

  update() {
    showLoading();
    TaskService.instance.update(
      id: widget.item!.id,
      update: (item) {
        item.taskName = taskName;
        item.assignedTo = assignedTo;
        item.description = description;
        item.status = status;
      },
    );
    hideLoading();
    Get.back();
    ss("Data updated");
  }
}
