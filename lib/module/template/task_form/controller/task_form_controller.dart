import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

mixin TaskFormDataController {
  String? taskName;
  String? description;
  String? status = "Pending";
  UserProfile? assignedTo;

  loadCurrentData(Task current) {
    taskName = current.taskName;
    description = current.description;
    status = current.status;
    assignedTo = current.assignedTo;
  }

  createData() {
    TaskService.instance.add(
      Task(
        ObjectId(),
        createdAt: DateTime.now(),
        createdBy: userProfile,
        assignedTo: assignedTo,
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
        item.taskName = taskName;
        item.assignedTo = assignedTo;
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
