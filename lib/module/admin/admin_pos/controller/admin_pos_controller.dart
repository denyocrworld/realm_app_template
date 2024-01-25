import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';
import '../view/admin_pos_view.dart';

class AdminPosController extends State<AdminPosView> {
  static late AdminPosController instance;
  late AdminPosView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  Map values = {};
  Map prices = {};

  setPrice(ObjectId id, double price) {
    prices[id.toString()] = price;
  }

  increaseQty(ObjectId id) {
    values[id.toString()] = values[id.toString()] ?? 0;
    values[id.toString()]++;
    setState(() {});
  }

  decreaseQty(ObjectId id) {
    values[id.toString()] = values[id.toString()] ?? 0;
    if (values[id.toString()] == 0) return;
    values[id.toString()]--;
    setState(() {});
  }

  getQty(ObjectId id) {
    return values[id.toString()] ?? 0;
  }

  double getTotal() {
    double total = 0;

    values.forEach((key, qty) {
      var price = prices[key];
      total += qty * price;
    });

    return total;
  }

  emptyQty() {
    values = {};
    payAmount = 0;
    setState(() {});
  }

  double payAmount = 0;
  setPayAmount(double amount) {
    payAmount = amount;
    setState(() {});
  }

  double get returnAmount {
    return payAmount - getTotal();
  }

  String search = "";
  updateSearch(String value) {
    search = value;
    setState(() {});
  }
}
