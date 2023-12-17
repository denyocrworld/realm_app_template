import 'dart:io';
import 'extension.dart';
import 'get_modules.dart';
import 'module.dart';

void main() {
  var modules = getModules();

  var formViewTemplate =
      File("lib/module/template/task_form/view/task_form_view.dart");

  var formControllerTemplate = File(
      "lib/module/template/task_form/controller/task_form_controller.dart");

  var listViewTemplate =
      File("lib/module/template/task_list/view/task_list_view.dart");

  var listControllerTemplate = File(
      "lib/module/template/task_list/controller/task_list_controller.dart");

  for (var m in modules) {
    for (var field in m.fields) {
      print(field.keyName);
      print(field.variableName);
      print(field.className);
      print(field.titleName);
    }

    var formViewFile = File(
        "lib/module/generated/${m.keyName}/${m.keyName}_form/view/${m.keyName}_form_view.dart");
    var formControllerFile = File(
        "lib/module/generated/${m.keyName}/${m.keyName}_form/controller/${m.keyName}_form_controller.dart");
    var formWidgetFile =
        File("lib/module/generated/${m.keyName}/${m.keyName}_form/widget/_");

    var listViewFile = File(
        "lib/module/generated/${m.keyName}/${m.keyName}_list/view/${m.keyName}_list_view.dart");
    var listControllerFile = File(
        "lib/module/generated/${m.keyName}/${m.keyName}_list/controller/${m.keyName}_listcontroller.dart");
    var listWidgetFile =
        File("lib/module/generated/${m.keyName}/${m.keyName}_list/widget/_");

    formViewFile.createSync(recursive: true);
    formControllerFile.createSync(recursive: true);
    listViewFile.createSync(recursive: true);
    listControllerFile.createSync(recursive: true);
    formWidgetFile.createSync(recursive: true);
    listWidgetFile.createSync(recursive: true);

    {
      var template = formViewTemplate.readAsStringSync();
      formViewFile.writeAsStringSync(template);
    }

    {
      var template = formControllerTemplate.readAsStringSync();
      formControllerFile.writeAsStringSync(template);
    }

    {
      var template = listViewTemplate.readAsStringSync();
      listViewFile.writeAsStringSync(template);
    }

    {
      var template = listControllerTemplate.readAsStringSync();
      listControllerFile.writeAsStringSync(template);
    }
  }
}
