import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSubmitted;
  final ValueChanged<String> onChanged;
  final FocusNode focusNode;
  final VoidCallback onPressed;
  final VoidCallback onClear;

  const SearchField({
    super.key,
    required this.controller,
    required this.onSubmitted,
    required this.onChanged,
    required this.focusNode,
    required this.onPressed,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 20),
          label: Text(LocaleKeys.character_search.watchTr(context)),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.lightGrey,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (
              BuildContext context,
              TextEditingValue value,
              Widget? child,
            ) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (value.text.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        controller.clear();
                        focusNode.unfocus();
                        onClear();
                      },
                    ),
                  IconButton(
                    onPressed: () {
                      onPressed();
                      focusNode.unfocus();
                    },
                    icon: const Icon(
                      Icons.search,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        onSubmitted: onSubmitted,
        onChanged: onChanged,
      ),
    );
  }
}
