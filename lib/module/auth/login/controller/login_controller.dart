import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';

class LoginController extends State<LoginView> {
  static late LoginController instance;
  late LoginView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  String email = "admin@demo.com";
  String password = "123456";

  login() async {
    showLoading();
    try {
      var isSuccess = await AuthService.login(
        email: email,
        password: password,
      );
      hideLoading();

      if (!isSuccess) {
        se("Wrong email or password!");
        return;
      }

      if (isAdmin) Get.offAll(AdminMainNavigationView());
      if (isUser) Get.offAll(UserMainNavigationView());
    } on Exception catch (ex) {
      hideLoading();
      se(ex.toString());
    }
  }
}
