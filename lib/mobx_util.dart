import 'package:flutter/material.dart';

abstract class ControllerBase {
  initState();
  ready();
  dispose();
}

abstract class ViewBase {
  Widget buildView(BuildContext context) {
    return Container();
  }
}