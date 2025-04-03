import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class GenderSelector extends ConsumerStatefulWidget {
  const GenderSelector({super.key});

  @override
  ConsumerState<GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends ConsumerState<GenderSelector> {
  late final TextEditingController _customGenderController;

  @override
  void initState() {
    super.initState();
    _customGenderController = TextEditingController(
      text: ref.read(authFormControllerProvider).customGender,
    );
  }

  @override
  void dispose() {
    _customGenderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthFormState formState = ref.watch(authFormControllerProvider);
    final AuthFormController formController = ref.read(authFormControllerProvider.notifier);

    return Column(
      children: <Widget>[
        DropdownButtonFormField(
          value: formState.gender,
          items: Gender.values.map((Gender gender) {
            return DropdownMenuItem<Gender>(
              value: gender,
              child: Row(
                children: <Widget>[
                  Icon(gender.icon),
                  const SizedBox(width: AppSize.size10),
                  Text(gender.label),
                ],
              ),
            );
          }).toList(),
          onChanged: (Gender? value) {
            if (value != null) {
              formController.update(
                gender: value,
                showCustomGenderField: value == Gender.other,
                customGender:
                    value == Gender.other ? formState.customGender : null,
              );
            }
          },
          decoration: InputDecoration(
            labelText: LocaleKeys.auth_gender.watchTr(context),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.person_outline),
          ),
        ),
        if (formState.showCustomGenderField) ...<Widget>[
          const SizedBox(height: AppSize.size25),
          CustomTextField(
            controller: _customGenderController,
            labelText: LocaleKeys.auth_gender.watchTr(context),
            icon: const Icon(Icons.edit),
            validator: (String? value) => Validators.genderValidator(
              value,
              context,
            ),
            onChanged: (String? value) =>
                formController.update(customGender: value),
          ),
        ],
      ],
    );
  }
}
