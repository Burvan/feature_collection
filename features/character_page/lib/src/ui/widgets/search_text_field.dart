import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final FocusNode focusNode;
  final VoidCallback onClear;

  const SearchField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.focusNode,
    required this.onClear,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextField(
        controller: widget.controller,
        focusNode: widget.focusNode,
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
            valueListenable: widget.controller,
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
                        widget.controller.clear();
                        widget.focusNode.unfocus();
                        widget.onClear();
                      },
                    ),
                  const Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Icon(Icons.search),
                  ),
                ],
              );
            },
          ),
        ),
        onChanged: (String query) {
          if (_debounce?.isActive ?? false) _debounce!.cancel();
          _debounce = Timer(
            const Duration(milliseconds: 300),
            () => widget.onChanged(query),
          );
        },
        onTapOutside: (PointerDownEvent event) => widget.focusNode.unfocus(),
      ),
    );
  }
}
