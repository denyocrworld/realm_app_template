import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

mixin TaskFormDataController {
  UserProfile? createdBy;
  UserProfile? assignedTo;
  DateTime? createdAt;
  String? taskName;
  String? description;
  String? status;

  loadCurrentData(Task current) {
    createdBy = current.createdBy;
    assignedTo = current.assignedTo;
    createdAt = current.createdAt;
    taskName = current.taskName;
    description = current.description;
    status = current.status;
  }

  createData() {
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
  }

  updateData(Task current) {
    TaskService.instance.update(
      id: current.id,
      update: (item) {
        item.createdBy = createdBy;
        item.assignedTo = assignedTo;
        item.createdAt = createdAt;
        item.taskName = taskName;
        item.description = description;
        item.status = status;
      },
    );
  }
}

class TaskFormController extends State<TaskFormView>
    with BasicState, TaskFormDataController {
  static late TaskFormController instance;
  late TaskFormView view;

  @override
  void initState() {
    instance = this;
    if (isEditMode) {
      loadCurrentData(widget.item!);
    }
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  bool get isEditMode => widget.item != null;
  bool get isCreateMode => widget.item == null;

  save() {
    if (isNotValid) return;
    if (isCreateMode) create();
    if (isEditMode) update();
  }

  create() => handleCreate(createData);
  update() => handleUpdate(updateData, widget.item!);
}
