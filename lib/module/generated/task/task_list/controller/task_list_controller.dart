import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

mixin TaskListDataController {
  deleteData(Task item) {
    TaskService.instance.delete(item);
  }
}

class TaskListController extends State<TaskListView>
    with BasicState, TaskListDataController {
  static late TaskListController instance;
  late TaskListView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  delete(Task item) {
    showLoading();
    deleteData(item);
    hideLoading();
  }

  String status = "Pending";
  updateStatus(String value) {
    status = value;
    setState(() {});
  }
}
