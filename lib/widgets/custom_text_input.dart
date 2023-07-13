import 'package:flutter/material.dart';

class CustomTextInput extends StatefulWidget {
  final String textInputKey;
  final String textHint;
  final TextEditingController controller;
  final bool isGrouped;

  const CustomTextInput(
      {required this.textInputKey,
      required this.textHint,
      required this.controller,
      this.isGrouped = false,
      super.key});

  @override
  State<CustomTextInput> createState() => _CustomTextInput();
}

class _CustomTextInput extends State<CustomTextInput> {
  bool fieldIsFocused = false;

  @override
  Widget build(BuildContext context) {
    Color fieldBgFill = widget.isGrouped
        ? Colors.white.withOpacity(fieldIsFocused ? 1 : 0)
        : Colors.white.withOpacity(1);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        boxShadow: fieldIsFocused
            ? [
                BoxShadow(
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.32),
                  spreadRadius: 3.0,
                ),
              ]
            : null,
      ),
      child: FocusScope(
          child: Focus(
        onFocusChange: (focus) => setState(() {
          fieldIsFocused = focus;
        }),
        child: TextFormField(
          key: ValueKey(widget.textInputKey),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context)
                      .colorScheme
                      .outline
                      .withOpacity(widget.isGrouped ? 0 : 1)),
            ),
            hintText: widget.textHint,
            border: const OutlineInputBorder(),
            fillColor: fieldBgFill,
            filled: true,
          ),
          controller: widget.controller,
        ),
      )),
    );
  }
}
