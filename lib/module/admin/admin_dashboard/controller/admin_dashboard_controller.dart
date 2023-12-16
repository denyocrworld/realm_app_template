import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';
import '../view/admin_dashboard_view.dart';

class AdminDashboardController extends State<AdminDashboardView> {
  static late AdminDashboardController instance;
  late AdminDashboardView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
