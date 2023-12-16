// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

class RealmDocumentView<T> extends StatelessWidget {
  final Stream<RealmResultsChanges?> stream;
  final Function(T item) itemBuilder;
  const RealmDocumentView({
    Key? key,
    required this.stream,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) return const Text("Error");
        if (!snapshot.hasData) return const Text("No Data");
        if (snapshot.error != null) return Container();

        // return Text("${snapshot.data!.results.length}");
        var items = snapshot.data!.results;
        if (items.isEmpty) return Container();
        return itemBuilder(items.first as T);
      },
    );
  }
}
