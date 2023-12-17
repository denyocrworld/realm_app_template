import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

mixin HUITemplateFormDataController {
  //@VARIABLE

  loadCurrentData(Task current) {
    //@CURRENT_DATA
  }

  createData() {
    TaskService.instance.add(
      Task(
        ObjectId(),
        //@CREATE_DATA
      ),
    );
  }

  updateData(Task current) {
    TaskService.instance.update(
      id: current.id,
      update: (item) {
        //@UPDATE_DATA
      },
    );
  }
}

class HUITemplateFormController extends State<HUITemplateFormView>
    with BasicState, HUITemplateFormDataController {
  static late HUITemplateFormController instance;
  late HUITemplateFormView view;

  @override
  void initState() {
    instance = this;
    if (isEditMode) {
      loadCurrentData(widget.item!);
    }
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  bool get isEditMode => widget.item != null;
  bool get isCreateMode => widget.item == null;

  save() {
    if (isNotValid) return;
    if (isCreateMode) create();
    if (isEditMode) update();
  }

  create() => handleCreate(createData);
  update() => handleUpdate(updateData, widget.item!);
}
