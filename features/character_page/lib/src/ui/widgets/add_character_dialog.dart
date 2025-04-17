import 'package:character_page/src/bloc/character_bloc.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class AddCharacterDialog extends StatefulWidget {
  final CharacterBloc bloc;

  const AddCharacterDialog({
    required this.bloc,
    super.key,
  });

  @override
  State<AddCharacterDialog> createState() => _AddCharacterDialogState();
}

class _AddCharacterDialogState extends State<AddCharacterDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _houseController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _statusController.dispose();
    _houseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      bloc: widget.bloc,
      builder: (BuildContext context, CharacterState state) {
        return AlertDialog(
          title: Text(LocaleKeys.character_addNewCharacter.watchTr(context)),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  CustomTextField(
                    labelText: LocaleKeys.character_name.watchTr(context),
                    controller: _nameController,
                    validator: (String? value) =>
                        Validators.newCharacterValidator(
                      value,
                      context,
                    ),
                  ),
                  CustomTextField(
                    labelText:
                        LocaleKeys.character_description.watchTr(context),
                    controller: _descriptionController,
                    validator: (String? value) =>
                        Validators.newCharacterValidator(
                      value,
                      context,
                    ),
                  ),
                  CustomTextField(
                    labelText: LocaleKeys.character_status.watchTr(context),
                    controller: _statusController,
                    validator: (String? value) =>
                        Validators.newCharacterValidator(
                      value,
                      context,
                    ),
                  ),
                  CustomTextField(
                    labelText:
                        LocaleKeys.character_dialogHouse.watchTr(context),
                    controller: _houseController,
                    validator: (String? value) =>
                        Validators.newCharacterValidator(
                      value,
                      context,
                    ),
                  ),
                  const SizedBox(height: AppSize.size10),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => widget.bloc.add(
                const NavigateToPreviousScreenEvent(),
              ),
              child: Text(
                LocaleKeys.character_cancel.watchTr(context),
              ),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  widget.bloc.add(
                    AddCharacterEvent(
                      character: Character(
                        id: DateTime.now().millisecondsSinceEpoch,
                        name: _nameController.text,
                        description: _descriptionController.text,
                        imagePath: AppConstants.defaultCharacterImageUrl,
                        house: _houseController.text,
                        status: _statusController.text,
                      ),
                    ),
                  );
                  widget.bloc.add(const NavigateToPreviousScreenEvent());
                }
              },
              child: state.isLoading
                  ? const CircularProgressIndicator()
                  : Text(LocaleKeys.character_add.watchTr(context)),
            ),
          ],
        );
      },
    );
  }
}
