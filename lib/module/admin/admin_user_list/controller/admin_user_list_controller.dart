import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

class AdminUserListController extends State<AdminUserListView> {
  static late AdminUserListController instance;
  late AdminUserListView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  delete(UserProfile item) async {
    UserProfileService.instance.delete(item);
  }
}
