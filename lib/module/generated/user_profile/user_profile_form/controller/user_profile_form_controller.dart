import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

class UserProfileFormController extends State<UserProfileFormView> {
  static late UserProfileFormController instance;
  late UserProfileFormView view;

  @override
  void initState() {
    instance = this;
    if (isEditMode) {
      name = current!.name;
      email = current!.email;
      password = current!.password;
      role = current!.role;
      photo = current!.photo;
    }
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool loading = false;

  bool get isNotValid {
    bool isValid = formKey.currentState!.validate();
    return !isValid;
  }

  bool get isValid {
    bool isValid = formKey.currentState!.validate();
    return isValid;
  }

  UserProfile? get current => widget.item;
  bool get isEditMode => current != null;
  bool get isCreateMode => current == null;

  String? name;
  String? email;
  String? password;
  String? role;
  String? photo;

  save() {
    if (isNotValid) return;
    if (isCreateMode) create();
    if (isEditMode) update();
  }

  create() {
    showLoading();
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
    hideLoading();
    Get.back();
    ss("Data created");
  }

  update() {
    showLoading();
    UserProfileService.instance.update(
      id: current!.id,
      update: (item) {
        item.name = name;
        item.email = email;
        item.password = password;
        item.role = role;
        item.photo = photo;
      },
    );
    hideLoading();
    Get.back();
    ss("Data updated");
  }
}
