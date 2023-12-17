import 'dart:io';

import 'extension.dart';
import 'module.dart';

List<Module> getModules() {
  var file = File('lib/model/model.dart');
  var lines = file.readAsLinesSync();
  bool startLine = false;
  List keys = [];
  List types = [];

  List<Module> modules = [];
  late Module current;
  late List<Field> fields;

  for (var line in lines) {
    if (line.trim().endsWith("{")) {
      startLine = true;
      var className = line.split(" ")[1].replaceAll("_", "");

      fields = [];
      current = Module(
        keyName: className.keyName,
        titleName: className.titleCase,
        variableName: className.variableName,
        className: className,
        fields: [],
      );
    }

    if (line.trim().startsWith("}")) {
      startLine = false;
      current.fields = fields;
      modules.add(current);
    }

    if (startLine) {
      List<String> skips = [
        '@MapTo("_id")',
        '@PrimaryKey()',
        'late ObjectId id;',
      ];
      if (skips.contains(line.trim())) continue;

      if (line.contains(";")) {
        var arr = line.split(" ");
        var variableName = line.split(" ").last.replaceAll(";", "");
        var variableType = arr[arr.length - 2];
        if (variableType.startsWith("_")) {
          variableType = variableType.substring(1, variableType.length);
        }

        fields.add(Field(
          type: variableType,
          variableName: variableName,
          className: variableName.className,
          keyName: variableName.keyName,
          titleName: variableName.titleCase,
        ));
      }
    }
  }
  return modules;
}
