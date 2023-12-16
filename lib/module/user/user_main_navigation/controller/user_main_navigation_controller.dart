import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';
import '../view/user_main_navigation_view.dart';

class UserMainNavigationController extends State<UserMainNavigationView> {
  static late UserMainNavigationController instance;
  late UserMainNavigationView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  int selectedIndex = 0;
  updateIndex(int newIndex) {
    selectedIndex = newIndex;
    setState(() {});
  }
}
