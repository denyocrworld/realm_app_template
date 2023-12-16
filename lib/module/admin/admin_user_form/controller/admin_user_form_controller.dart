import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

class AdminUserFormController extends State<AdminUserFormView> {
  static late AdminUserFormController instance;
  late AdminUserFormView view;

  @override
  void initState() {
    instance = this;
    loadCurrentData();
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? name;
  String? email;
  String? password;
  String? role = "User";

  bool get isEditMode => widget.item != null;
  bool get isCreateMode => widget.item == null;

  loadCurrentData() {
    if (isEditMode == false) return;
    name = widget.item!.name;
    email = widget.item!.email;
    password = widget.item!.password;
    role = widget.item!.role;
  }

  save() async {
    bool isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    if (isEditMode) update();
    if (isCreateMode) create();
  }

  create() async {
    showLoading();
    try {
      bool isSuccess = await AuthService.register(
        email: email!,
        password: password!,
      );
      if (!isSuccess) {
        hideLoading();
        se("Failed to create account, already exists!");
        return;
      }
    } on Exception catch (err) {
      hideLoading();
      se(err.toString());
      return;
    }
    try {
      UserProfileService.instance.add(UserProfile(
        ObjectId(),
        name: name,
        email: email,
        password: password,
        role: role,
      ));
      hideLoading();
      Get.back();
      ss("Create success");
    } on Exception catch (err) {
      hideLoading();
      se(err.toString());
      return;
    }
    hideLoading();

    Get.back();
  }

  update() async {
    showLoading();
    try {
      UserProfileService.instance.update(
        id: widget.item!.id,
        update: (item) {
          item.name = name;
          item.role = role;
        },
      );
      hideLoading();
      Get.back();
      ss("Update success");
    } on Exception catch (err) {
      hideLoading();
      se(err.toString());
      return;
    }
  }
}
