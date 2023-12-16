import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';
import '../view/admin_main_navigation_view.dart';

class AdminMainNavigationController extends State<AdminMainNavigationView> {
  static late AdminMainNavigationController instance;
  late AdminMainNavigationView view;

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
