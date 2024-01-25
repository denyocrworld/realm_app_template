import 'package:realm_app/core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runMainApp();
}

runMainApp() async {
  return runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool loading = true;
  @override
  void initState() {
    super.initState();
    initialize();
  }

  initialize() async {
    loading = true;
    setState(() {});
    await RealmAppService.init();
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget mainView = LoginView();
    if (loading)
      mainView = Scaffold(
        body: Center(
          child: Text("Loading.."),
        ),
      );

    return MaterialApp(
      title: 'RealmApp',
      navigatorKey: Get.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: getDefaultTheme(),
      home: mainView,
      builder: (context, child) {
        return Stack(
          children: [
            child!,
            Positioned(
              right: 10,
              bottom: 10,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Get.to(ModuleDashboard()),
                  child: CircleAvatar(
                    radius: 12.0,
                    backgroundColor: Colors.red,
                    child: Icon(
                      Icons.bug_report,
                      color: Colors.white,
                      size: 16.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
