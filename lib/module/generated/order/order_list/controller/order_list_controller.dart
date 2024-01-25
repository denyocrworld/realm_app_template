import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

class OrderListController extends State<OrderListView> {
  static late OrderListController instance;
  late OrderListView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  delete(Order item) {
    showLoading();
    OrderService.instance.delete(item);
    hideLoading();
  }

  //@SEARCH
  String search = "";
  updateSearch(String value) {
    search = value;
    setState(() {});
  }
  //@:SEARCH
}
