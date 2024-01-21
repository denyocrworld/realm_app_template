import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

class TaskFormController extends State<TaskFormView> {
  static late TaskFormController instance;
  late TaskFormView view;

  @override
  void initState() {
    instance = this;
    if (isEditMode) {
      createdBy = current!.createdBy;
      assignedTo = current!.assignedTo;
      createdAt = current!.createdAt;
      taskName = current!.taskName;
      description = current!.description;
      status = current!.status;
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

  Task? get current => widget.item;
  bool get isEditMode => current != null;
  bool get isCreateMode => current == null;

  UserProfile? createdBy;
  UserProfile? assignedTo;
  DateTime? createdAt;
  String? taskName;
  String? description;
  String? status;

  save() {
    if (isNotValid) return;
    if (isCreateMode) create();
    if (isEditMode) update();
  }

  create() {
    showLoading();
    TaskService.instance.add(
      Task(
        ObjectId(),
        createdBy: userProfile,
        assignedTo: assignedTo,
        createdAt: DateTime.now(),
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
      id: current!.id,
      update: (item) {
        item.createdBy = createdBy;
        item.assignedTo = assignedTo;
        item.createdAt = createdAt;
        item.taskName = taskName;
        item.description = description;
        item.status = status;
      },
    );
    hideLoading();
    Get.back();
    ss("Data updated");
  }
}
