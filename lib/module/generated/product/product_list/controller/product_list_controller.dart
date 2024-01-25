import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

class ProductListController extends State<ProductListView> {
  static late ProductListController instance;
  late ProductListView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  delete(Product item) {
    showLoading();
    ProductService.instance.delete(item);
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
