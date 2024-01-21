import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

class TaskListController extends State<TaskListView> {
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
    TaskService.instance.delete(item);
    hideLoading();
  }

  //@STATUS_FILTER
  String status = "Pending";
  updateStatus(String value) {
    status = value;
    setState(() {});
  }
  //@:STATUS_FILTER
}
