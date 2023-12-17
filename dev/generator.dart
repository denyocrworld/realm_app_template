import 'dart:io';
import 'extension.dart';
import 'get_modules.dart';
import 'module.dart';

List<Module> modules = [];

bool isModule(String className, String fieldKeyName) {
  className = className.replaceAll("?", "").trim();
  bool exists =
      modules.indexWhere((e) => e.className.trim() == className.trim()) > -1;

  var fieldClassName = fieldKeyName.className;

  if (exists) {
    var widgetFile =
        File("lib/shared/app/widget/${fieldKeyName}_dropdown.dart");
    widgetFile.createSync(recursive: true);
    var content = """
import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

class ${fieldClassName}DropdownField extends StatelessWidget {
  final String label;
  final dynamic value;
  final dynamic Function(dynamic, String?) onChanged;
  final String? Function(Map<String, dynamic>?)? validator;

  const ${fieldClassName}DropdownField({
    Key? key,
    required this.onChanged,
    required this.label,
    required this.value,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RealmListView<UserProfile>(
      stream: UserProfileService.instance.snapshot(),
      itemsBuilder: (items) {
        return QDropdownField(
          label: label,
          validator: validator,
          items: items.map((e) {
            return {
              "label": e!.name,
              "value": e,
            };
          }).toList(),
          value: value,
          onChanged: (value, label) {
            onChanged(value, label);
          },
        );
      },
    );
  }
}
""";
    content = content.replaceAll("UserProfile", className);
    widgetFile.writeAsStringSync(content);
  }
  return exists;
}

void main() {
  modules = getModules();

  var formViewTemplate =
      File("lib/module/template/task_form/view/task_form_view.dart");

  var formControllerTemplate = File(
      "lib/module/template/task_form/controller/task_form_controller.dart");

  var listViewTemplate =
      File("lib/module/template/task_list/view/task_list_view.dart");

  var listControllerTemplate = File(
      "lib/module/template/task_list/controller/task_list_controller.dart");

  for (var m in modules) {
    print(m.className);
    for (var field in m.fields) {}

    var formViewFile = File(
        "lib/module/generated/${m.keyName}/${m.keyName}_form/view/${m.keyName}_form_view.dart");
    var formControllerFile = File(
        "lib/module/generated/${m.keyName}/${m.keyName}_form/controller/${m.keyName}_form_controller.dart");
    var formWidgetFile =
        File("lib/module/generated/${m.keyName}/${m.keyName}_form/widget/_");

    var listViewFile = File(
        "lib/module/generated/${m.keyName}/${m.keyName}_list/view/${m.keyName}_list_view.dart");
    var listControllerFile = File(
        "lib/module/generated/${m.keyName}/${m.keyName}_list/controller/${m.keyName}_list_controller.dart");
    var listWidgetFile =
        File("lib/module/generated/${m.keyName}/${m.keyName}_list/widget/_");

    var serviceFile =
        File("lib/service/${m.keyName}/${m.keyName}_service.dart");

    formViewFile.createSync(recursive: true);
    formControllerFile.createSync(recursive: true);
    listViewFile.createSync(recursive: true);
    listControllerFile.createSync(recursive: true);
    formWidgetFile.createSync(recursive: true);
    listWidgetFile.createSync(recursive: true);
    serviceFile.createSync(recursive: true);

    {
      var template = formViewTemplate.readAsStringSync().fix(m);
      formViewFile.writeAsStringSync(template);
    }

    {
      var template = formControllerTemplate.readAsStringSync().fix(m);
      formControllerFile.writeAsStringSync(template);
    }

    {
      var template = listViewTemplate.readAsStringSync().fix(m);
      listViewFile.writeAsStringSync(template);
    }

    {
      var template = listControllerTemplate.readAsStringSync().fix(m);
      listControllerFile.writeAsStringSync(template);
    }
    {
      var template = """
import 'package:realm/realm.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

class TaskService extends RealmBaseService<Task> {
  static TaskService? _instance;
  static TaskService get instance => _instance ??= TaskService();
  static SchemaObject schema = Task.schema;
}
"""
          .trim()
          .fix(m);
      serviceFile.writeAsStringSync(template);
    }
  }
}

extension TemplateUpdater on String {
  String fix(Module m) {
    var template = this;
    template = template.replaceAll("Task Form", "${m.titleName} Form");
    template = template.replaceAll("Task List", "${m.titleName} List");
    template = template.replaceAll("Task", m.className);

    var count = 0;
    for (var f in m.fields) {
      if (f.type == "String?") {
        if (count == 0) {
          template =
              template.replaceAll("item.taskName", "item." + f.variableName);
        } else if (count == 1) {
          template =
              template.replaceAll("item.description", "item." + f.variableName);
        }
        count++;
      }
    }

    {
      List lines = [];
      for (var field in m.fields) {
        lines.add("${field.type} ${field.variableName};");
      }
      template = template.replaceAll("//@VARIABLE", lines.join("\n"));
    }

    {
      List lines = [];
      for (var field in m.fields) {
        lines.add("${field.variableName} = current.${field.variableName};");
      }
      template = template.replaceAll("//@CURRENT_DATA", lines.join("\n"));
    }

    {
      List lines = [];
      for (var field in m.fields) {
        lines.add("${field.variableName}: ${field.variableName},");
      }
      template = template.replaceAll("//@CREATE_DATA", lines.join("\n"));
    }

    {
      List lines = [];
      for (var field in m.fields) {
        lines.add("item.${field.variableName} = ${field.variableName};");
      }
      template = template.replaceAll("//@UPDATE_DATA", lines.join("\n"));
    }

    {
      List lines = [];
      for (var field in m.fields) {
        // Skip Fields
        if (field.keyName == "created_by") continue;
        if (field.keyName == "created_at") continue;
        //END

        if (field.keyName == "status") {
          lines.add("""
QDropdownField(
  label: "Status",
  validator: Validator.required,
  items: ds.status,
  value: controller.status,
  onChanged: (value, label) {
    controller.status = value;
  },
),
"""
              .trim());
          continue;
        }

        if (isModule(field.type, field.keyName) == true) {
          lines.add("""
${field.className}DropdownField(
  label: "${field.titleName}",
  validator: Validator.required,
  value: controller.${field.variableName},
  onChanged: (value, label) {
    controller.${field.variableName} = value;
  },
),
"""
              .trim());
          continue;
        }

        if (field.keyName == "description") {
          lines.add("""
QMemoField(
  label: "${field.titleName}",
  validator: Validator.required,
  value: controller.${field.variableName},
  onChanged: (value) {
    controller.${field.variableName} = value;
  },
),
"""
              .trim());
          continue;
        }

        if (field.type == "double") {
          lines.add("""
QNumberField(
  label: "${field.titleName}",
  validator: Validator.required,
  value: controller.${field.variableName},
  onChanged: (value) {
    controller.${field.variableName} = value;
  },
),
"""
              .trim());
          continue;
        }

        if (field.keyName.contains("photo") ||
            field.keyName.contains("image")) {
          lines.add("""
QImagePicker(
  label: "${field.titleName}",
  validator: Validator.required,
  value: controller.${field.variableName},
  onChanged: (value) {
    controller.${field.variableName} = value;
  },
),
"""
              .trim());
          continue;
        }

        lines.add("""
QTextField(
  label: "${field.titleName}",
  validator: Validator.required,
  value: controller.${field.variableName},
  onChanged: (value) {
    controller.${field.variableName} = value;
  },
),
"""
            .trim());
      }
      template = template.replaceAll("//@FORM", lines.join("\n"));
    }

    //CuSTOM
    template = template.replaceAll(
      "createdAt: createdAt",
      "createdAt: DateTime.now()",
    );
    template = template.replaceAll(
      "createdBy: createdBy",
      "createdBy: userProfile",
    );
    //---

    return template;
  }
}
