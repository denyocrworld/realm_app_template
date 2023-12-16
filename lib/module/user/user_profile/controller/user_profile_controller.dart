import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

class UserProfileController extends State<UserProfileView> {
  static late UserProfileController instance;
  late UserProfileView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  logout() async {
    showLoading();
    await AuthService.logout();
    hideLoading();
    Get.offAll(LoginView());
  }

  late UserProfile current;
  String? name;
  save() async {
    bool isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    showLoading();
    UserProfileService.instance.update(
      id: current.id,
      update: (item) {
        item.name = name ?? current.name;
      },
    );
    hideLoading();
    Get.back();
    ss("Data updated");
  }
}
