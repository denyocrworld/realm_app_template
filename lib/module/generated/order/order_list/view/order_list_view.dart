import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

class OrderListView extends StatefulWidget {
  OrderListView({Key? key}) : super(key: key);

  Widget build(context, OrderListController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: Text("Order List"),
        actions: [
          RealmDelete(OrderService.instance),
          RealmSearch(
            value: controller.search,
            onSearch: (value) => controller.updateSearch(value),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: RealmListView<Order>(
              stream: OrderService.instance.snapshot(query: ""),
              padding: EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              itemBuilder: (item, index) {
                //@SEARCH
                bool searchCondition = item.customerName!
                    .toLowerCase()
                    .contains(controller.search.toLowerCase());
                if (controller.search.isNotEmpty && !searchCondition) {
                  return SizedBox.shrink();
                }
                //@:SEARCH

                return QDismissible(
                  onDismiss: () => controller.delete(item),
                  child: ListTile(
                    title: Text(item.customerName ?? "-"),
                    onTap: () => Get.to(OrderFormView(item: item)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingAction(
        onPressed: () async {
          await Get.to(OrderFormView());
        },
      ),
    );
  }

  @override
  State<OrderListView> createState() => OrderListController();
}
