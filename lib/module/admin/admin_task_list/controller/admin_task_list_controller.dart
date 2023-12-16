import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

class AdminTaskListController extends State<AdminTaskListView> {
  static late AdminTaskListController instance;
  late AdminTaskListView view;

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

  String status = "Pending";
  updateStatus(String value) {
    status = value;
    setState(() {});
  }
}
