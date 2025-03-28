import 'package:auth/auth.dart';
import 'package:auth/src/ui/widgets/auth_widgets.dart';
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
              formNotifier.update(
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
          AuthTextField(
            controller: _customGenderController,
            labelText: LocaleKeys.auth_gender.watchTr(context),
            obscureText: false,
            icon: const Icon(Icons.edit),
            validator: (String? value) => Validators.genderValidator(
              value,
              context,
            ),
            onChanged: (String? value) =>
                formNotifier.update(customGender: value),
          ),
        ],
      ],
    );
  }
}
