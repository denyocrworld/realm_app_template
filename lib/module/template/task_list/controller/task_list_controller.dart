import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

mixin HUITemplateListDataController {
  deleteData(Task item) {
    TaskService.instance.delete(item);
  }
}

class HUITemplateListController extends State<HUITemplateListView>
    with BasicState, HUITemplateListDataController {
  static late HUITemplateListController instance;
  late HUITemplateListView view;

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
