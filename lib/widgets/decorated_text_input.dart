import 'package:flutter/material.dart';

class DecoratedTextInput extends StatefulWidget {
  final TextFormField child;

  const DecoratedTextInput({required this.child, super.key});

  @override
  State<DecoratedTextInput> createState() => _DecoratedTextInput();
}

class _DecoratedTextInput extends State<DecoratedTextInput> {
  bool fieldIsFocused = false;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        boxShadow: _getBoxShadow(fieldIsFocused),
      ),
      child: FocusScope(
          child: Focus(
              onFocusChange: (focus) => setState(() => fieldIsFocused = focus),
              child: widget.child)),
    );
  }

  List<BoxShadow>? _getBoxShadow(bool fieldIsFocused) {
    if (fieldIsFocused) {
      return [
        BoxShadow(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.32),
          spreadRadius: 3.0,
        )
      ];
    }
    return null;
  }
}
