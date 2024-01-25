import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

class ProductListView extends StatefulWidget {
  ProductListView({Key? key}) : super(key: key);

  Widget build(context, ProductListController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
        actions: [
          RealmDelete(ProductService.instance),
          RealmSearch(
            value: controller.search,
            onSearch: (value) => controller.updateSearch(value),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: RealmListView<Product>(
              stream: ProductService.instance.snapshot(query: ""),
              padding: EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              itemBuilder: (item, index) {
                //@SEARCH
                bool searchCondition = item.photo!
                    .toLowerCase()
                    .contains(controller.search.toLowerCase());
                if (controller.search.isNotEmpty && !searchCondition) {
                  return SizedBox.shrink();
                }
                //@:SEARCH

                return QDismissible(
                  onDismiss: () => controller.delete(item),
                  child: ListTile(
                    title: Text(item.photo ?? "-"),
                    subtitle: Text(item.productName ?? "-"),
                    onTap: () => Get.to(ProductFormView(item: item)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingAction(
        onPressed: () async {
          await Get.to(ProductFormView());
        },
      ),
    );
  }

  @override
  State<ProductListView> createState() => ProductListController();
}
