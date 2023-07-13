import 'package:flutter/material.dart';
import 'custom_text_input.dart';

class TextInputGroup extends StatelessWidget {
  final List<CustomTextInput> textFields;

  const TextInputGroup(this.textFields, {super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(1),
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          textFields.first,
          const Divider(
            thickness: 1.0,
            height: 1.0,
          ),
          textFields.last
        ],
      ),
    );
  }
}
