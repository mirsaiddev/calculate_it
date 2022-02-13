import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colors.dart';

class MyTextfield extends StatelessWidget {
  const MyTextfield({
    Key? key,
    this.labelText,
    this.onChanged,
    this.controller,
  }) : super(key: key);

  final String? labelText;

  final void Function(String)? onChanged;

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      controller: controller,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: labelText,
        hintText: 'Enter..',
        hintStyle: const TextStyle(color: Colors.grey),
        labelStyle: const TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: MyColors.purple,
            width: 2,
          ),
        ),
      ),
    );
  }
}
