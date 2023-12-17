import 'package:flutter/material.dart';

Widget FloatingAction({
  required Function onPressed,
}) {
  return FloatingActionButton(
    child: Icon(Icons.add),
    heroTag: UniqueKey(),
    onPressed: () => onPressed(),
  );
}
