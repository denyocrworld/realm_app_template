// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

class RealmListView<T> extends StatelessWidget {
  final Stream<RealmResultsChanges?> stream;
  final Function(T item, int index)? itemBuilder;
  final Function(RealmResults<T?> items)? itemsBuilder;
  final Function? onEmpty;
  final EdgeInsets? padding;
  final bool shrinkWrap;
  const RealmListView({
    Key? key,
    required this.stream,
    this.itemBuilder,
    this.itemsBuilder,
    this.onEmpty,
    this.padding,
    this.shrinkWrap = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError ||
            snapshot.data == null ||
            !snapshot.hasData ||
            snapshot.data!.results.isEmpty) {
          return onEmpty != null ? onEmpty!() : Container();
        }

        // return Text("${snapshot.data!.results.length}");
        var items = snapshot.data!.results;
        if (itemsBuilder != null) {
          return itemsBuilder!(items as RealmResults<T?>);
        }

        return ListView.builder(
          itemCount: items.length,
          shrinkWrap: shrinkWrap,
          // padding: padding ?? EdgeInsets.zero,
          padding: padding ?? const EdgeInsets.all(20.0),
          physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
          itemBuilder: (context, index) {
            T item = items[index] as T;
            return itemBuilder!(item, index);
          },
        );
      },
    );
  }
}

/*
//#TEMPLATE realm_list
RealmListView<UserProfile>(
  stream: UserProfileService.instance.snapshot(),
  itemBuilder: (item, index) {
    return QDismissible(
      onDismiss: () => controller.delete(item),
      child: ListTile(
        title: Text("${item.name}"),
        subtitle: Text("${item.email}"),
        onTap: () async {
          await Get.to(UserProfileFormView(
            item: item,
          ));
        },
      ),
    );
  },
),
//#END
*/
