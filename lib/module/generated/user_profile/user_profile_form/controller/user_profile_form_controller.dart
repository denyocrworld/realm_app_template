import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

mixin UserProfileFormDataController {
  String? name;
String? email;
String? password;
String? role;
String? photo;

  loadCurrentData(UserProfile current) {
    name = current.name;
email = current.email;
password = current.password;
role = current.role;
photo = current.photo;
  }

  createData() {
    UserProfileService.instance.add(
      UserProfile(
        ObjectId(),
        name: name,
email: email,
password: password,
role: role,
photo: photo,
      ),
    );
  }

  updateData(UserProfile current) {
    UserProfileService.instance.update(
      id: current.id,
      update: (item) {
        item.name = name;
item.email = email;
item.password = password;
item.role = role;
item.photo = photo;
      },
    );
  }
}

class UserProfileFormController extends State<UserProfileFormView>
    with BasicState, UserProfileFormDataController {
  static late UserProfileFormController instance;
  late UserProfileFormView view;

  @override
  void initState() {
    instance = this;
    if (isEditMode) {
      loadCurrentData(widget.item!);
    }
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  bool get isEditMode => widget.item != null;
  bool get isCreateMode => widget.item == null;

  save() {
    if (isNotValid) return;
    if (isCreateMode) create();
    if (isEditMode) update();
  }

  create() => handleCreate(createData);
  update() => handleUpdate(updateData, widget.item!);
}
