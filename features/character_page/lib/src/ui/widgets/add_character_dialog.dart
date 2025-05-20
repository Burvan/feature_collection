import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class AddCharacterDialog extends StatefulWidget {
  final VoidCallback onCancel;
  final ValueChanged<Character> onAdd;
  final ValueChanged<Status> onStatusChanged;
  final Widget addButtonChild;
  final Status selectedStatus;

  const AddCharacterDialog({
    required this.onCancel,
    required this.onAdd,
    required this.addButtonChild,
    required this.onStatusChanged,
    required this.selectedStatus,
    super.key,
  });

  @override
  State<AddCharacterDialog> createState() => _AddCharacterDialogState();
}

class _AddCharacterDialogState extends State<AddCharacterDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _houseController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _houseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        LocaleKeys.character_addNewCharacter.watchTr(context),
        textAlign: TextAlign.center,
      ),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CustomTextField(
                labelText: LocaleKeys.character_name.watchTr(context),
                controller: _nameController,
                validator: (String? value) => Validators.notEmptyValidator(
                  value,
                  context,
                ),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                labelText: LocaleKeys.character_description.watchTr(context),
                controller: _descriptionController,
                validator: (String? value) => Validators.notEmptyValidator(
                  value,
                  context,
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField2<Status>(
                isExpanded: true,
                value: widget.selectedStatus,
                decoration: InputDecoration(
                  labelText: LocaleKeys.character_status.watchTr(context),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: Status.values.map((Status status) {
                  return DropdownMenuItem<Status>(
                    value: status,
                    child: Text(status.localized(context)),
                  );
                }).toList(),
                onChanged: (Status? value) {
                  if (value != null) {
                    widget.onStatusChanged(value);
                  }
                },
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                labelText: LocaleKeys.character_dialogHouse.watchTr(context),
                controller: _houseController,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: widget.onCancel,
          child: Text(
            LocaleKeys.character_cancel.watchTr(context),
          ),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              widget.onAdd(
                Character(
                  id: DateTime.now().millisecondsSinceEpoch,
                  name: _nameController.text,
                  description: _descriptionController.text,
                  imagePath: AppConstants.defaultCharacterImageUrl,
                  house: _houseController.text.isNotEmpty
                      ? _houseController.text
                      : null,
                  status: widget.selectedStatus,
                ),
              );
              widget.onCancel();
            }
          },
          child: widget.addButtonChild,
        ),
      ],
    );
  }
}
