import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';
import '../controller/admin_pos_controller.dart';

class AdminPosView extends StatefulWidget {
  AdminPosView({Key? key}) : super(key: key);

  Widget build(context, AdminPosController controller) {
    controller.view = this;
    return Scaffold(
      appBar: AppBar(
        title: Text("AdminPos"),
        actions: [
          IconButton(
            onPressed: () => controller.emptyQty(),
            icon: const Icon(
              Icons.delete_forever,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: QTextField(
              label: "Search",
              validator: Validator.required,
              value: null,
              onChanged: (value) => controller.updateSearch(value),
            ),
          ),
          Expanded(
            child: RealmListView<Product>(
              stream: ProductService.instance.snapshot(),
              itemBuilder: (item, index) {
                controller.setPrice(item.id, item.price ?? 0);

                if (controller.search.isNotEmpty) {
                  var search = controller.search.toLowerCase();
                  var field = item.productName?.toLowerCase();
                  if (!field!.contains(search)) return Container();
                }
                return Container(
                  margin: const EdgeInsets.only(
                    bottom: 12.0,
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 42.0,
                        width: 42.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              item.photo!,
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              8.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${item.productName}",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              "${NumberFormat().format(item.price)}",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Container(
                        width: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () => controller.decreaseQty(item.id),
                              icon: const Icon(
                                Icons.remove,
                                size: 24.0,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "${controller.getQty(item.id)}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () => controller.increaseQty(item.id),
                              icon: const Icon(
                                Icons.add,
                                size: 24.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20.0),
        color: Colors.grey[300],
        child: Wrap(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Total",
                          key: UniqueKey(),
                          validator: Validator.required,
                          value: NumberFormat()
                              .format(controller.getTotal())
                              .toString(),
                          enabled: false,
                          onChanged: (value) {},
                        ),
                      ),
                      Expanded(
                        child: QNumberField(
                          label: "Pay amount",
                          key: UniqueKey(),
                          validator: Validator.required,
                          value: controller.payAmount.toString(),
                          onChanged: (value) {},
                          onSubmitted: (value) {
                            controller
                                .setPayAmount(double.tryParse(value) ?? 0);
                          },
                        ),
                      ),
                    ],
                  ),
                  QTextField(
                    label: "Return amount",
                    key: UniqueKey(),
                    validator: Validator.required,
                    enabled: false,
                    value: NumberFormat()
                        .format(controller.returnAmount)
                        .toString(),
                    onChanged: (value) {},
                  ),
                  AbsorbPointer(
                    absorbing: controller.returnAmount < 0,
                    child: QButton(
                      label: "Checkout",
                      color: controller.returnAmount < 0 ? disabledColor : null,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<AdminPosView> createState() => AdminPosController();
}
