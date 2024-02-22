import 'package:flutter/material.dart';

class BoxInputField extends StatelessWidget {
  final int? line;
  final Widget placeholder;
  final TextEditingController? controller;
  final Widget icon;
  final obscure;

  // final String? Function(String?)? validator;

  BoxInputField({
    super.key,
    this.line=1,
    required this.placeholder,
    this.controller, required this.icon, this.obscure=false,
  });

  InputBorder buildFocusBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20),
    ),
    borderSide: BorderSide(
      color: Colors.green,
      width: 1.5,
    ),
  );
  InputBorder buildBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
  );
  InputBorder buildenabled = const OutlineInputBorder(
    borderSide: BorderSide(
      width: 1.5,
      color: Colors.blue,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscure,
      textAlignVertical: TextAlignVertical.top,
      maxLines: line,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        icon: icon,
        errorMaxLines: 10,
        errorStyle: const TextStyle(
          overflow: TextOverflow.clip,
        ),
        label: placeholder,
        // labelStyle: TextStyle(),
        alignLabelWithHint: true,
        focusedBorder: buildFocusBorder,
        border: buildBorder,
        enabledBorder: buildenabled,
      ),
    );
  }
}
