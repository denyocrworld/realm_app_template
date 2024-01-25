import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';

class ModuleDashboard extends StatelessWidget {
  ModuleDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Module Dashboard"),
        actions: [],
      ),
      body: Builder(builder: (context) {
        List menuItems = [
          {
            "label": "UserProfileListView",
            "view": UserProfileListView(),
          },
          {
            "label": "UserProfileFormView",
            "view": UserProfileFormView(),
          },
          {
            "label": "TaskListView",
            "view": TaskListView(),
          },
          {
            "label": "TaskFormView",
            "view": TaskFormView(),
          },
          {
            "label": "ProductListView",
            "view": ProductListView(),
          },
          {
            "label": "ProductFormView",
            "view": ProductFormView(),
          },
        ];

        return GridView.builder(
          padding: const EdgeInsets.all(12.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1.0 / 0.3,
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: menuItems.length,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            var item = menuItems[index];
            return InkWell(
              onTap: () async {
                if (userProfile == null) {
                  await AuthService.login(
                    email: "admin@demo.com",
                    password: "123456",
                  );
                }
                Get.to(item["view"]);
              },
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 24,
                      offset: Offset(0, 11),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  border: Border.all(
                    width: 1.0,
                    color: Colors.grey[200]!,
                  ),
                ),
                child: Center(
                  child: Text(
                    "${item["label"]}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
