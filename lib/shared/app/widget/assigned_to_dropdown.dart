import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

class AssignedToDropdownField extends StatelessWidget {
  final String label;
  final dynamic value;
  final dynamic Function(dynamic, String?) onChanged;
  final String? Function(Map<String, dynamic>?)? validator;

  const AssignedToDropdownField({
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

/*
//#TEMPLATE dropdown_assigned_to
AssignedToDropdownField(
  label: "Assigned To",
  validator: Validator.required,
  value: controller.assignedTo,
  onChanged: (value, label) {
    controller.assignedTo = value;
  },
),
//#END
*/
