// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

class RealmCounter<T> extends StatelessWidget {
  final Stream<RealmResultsChanges?> stream;
  final Function(RealmResults<T?> items)? itemBuilder;
  final Function? onEmpty;
  final EdgeInsets? padding;
  final bool shrinkWrap;
  const RealmCounter({
    Key? key,
    required this.stream,
    this.itemBuilder,
    this.onEmpty,
    this.padding,
    this.shrinkWrap = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          if (onEmpty == null) return Container();
          return onEmpty!();
        }
        var items = snapshot.data!.results;
        return itemBuilder!(items as RealmResults<T?>);
      },
    );
  }
}

/*
//#TEMPLATE realm_counter
 RealmCounter<Task>(
  stream: TaskService.instance.snapshot(),
  itemBuilder: (items) {
    return Text(
      "${items.length}",
      style: TextStyle(
        fontSize: 12.0,
      ),
    );
  },
),
//#END
*/
