class Module {
  String keyName;
  String className;
  String variableName;
  String titleName;
  List<Field> fields;

  Module({
    required this.keyName,
    required this.className,
    required this.variableName,
    required this.titleName,
    required this.fields,
  });
}

class Field {
  String keyName;
  String className;
  String variableName;
  String titleName;
  String type;

  /*

  */

  Field({
    required this.keyName,
    required this.className,
    required this.variableName,
    required this.titleName,
    required this.type,
  });
}
