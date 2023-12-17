// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

class UserProfileDropdownField extends StatelessWidget {
  final String label;
  final dynamic value;
  final dynamic Function(dynamic, String?) onChanged;
  final String? Function(Map<String, dynamic>?)? validator;

  const UserProfileDropdownField({
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
