import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

mixin UserProfileListDataController {
  deleteData(UserProfile item) {
    UserProfileService.instance.delete(item);
  }
}

class UserProfileListController extends State<UserProfileListView>
    with BasicState, UserProfileListDataController {
  static late UserProfileListController instance;
  late UserProfileListView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  delete(UserProfile item) {
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
