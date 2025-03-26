import 'package:auth/auth.dart';
import 'package:auth/src/ui/widgets/auth_widgets.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
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
    final String? initialGender = ref.read(formNotifierProvider).customGender;
    _customGenderController = TextEditingController(text: initialGender);
  }

  @override
  void dispose() {
    _customGenderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthFormState formState = ref.watch(formNotifierProvider);
    final FormNotifier formNotifier = ref.read(formNotifierProvider.notifier);

    if (_customGenderController.text != formState.customGender) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _customGenderController.text = formState.customGender ?? '';
      });
    }

    return Column(
      children: <Widget>[
        DropdownButtonFormField(
          value: formState.gender,
          items: Gender.values.map((Gender gender) {
            return DropdownMenuItem<String>(
              value: gender.label,
              child: Row(
                children: <Widget>[
                  Icon(gender.icon),
                  const SizedBox(width: AppSize.size10),
                  Text(gender.label),
                ],
              ),
            );
          }).toList(),

          onChanged: (String? value) {
            if (value != null) {
              formNotifier.update(
                gender: value,
                showCustomGenderField: value == Gender.other.label,
                customGender: value == Gender.other.label
                    ? formState.customGender
                    : null,
              );
            }
          },
          decoration: InputDecoration(
            labelText: AppConstants.gender,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.person_outline),
          ),
        ),
        if (formState.showCustomGenderField) ...<Widget>[
          const SizedBox(height: AppSize.size25),
          AuthTextField(
            controller: _customGenderController,
            labelText: AppConstants.gender,
            obscureText: false,
            icon: const Icon(Icons.edit),
            validator: FieldValidator.genderValidator,
            onChanged: (String value) => formNotifier.update(customGender: value),
          ),
        ],
      ],
    );
  }
}