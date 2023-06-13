import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    this.enabled = true,
    this.focusNode,
    this.maxline = 1,
    this.textEditingController,
    this.validate,
  });
  final String? hintText;
  final bool? enabled;
  final int? maxline;
  final FocusNode? focusNode;
  final TextEditingController? textEditingController;
  final String? Function(String?)? validate;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: textEditingController,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      ),
      validator: validate,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white10,
        hintText: hintText ?? "",
        hintStyle: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.white38,
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.5,
            color: Colors.white24,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.5,
            color: Colors.white24,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.5,
            color: Colors.white24,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.5,
            color: Colors.white24,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
      maxLines: maxline,
      enabled: enabled,
    );
  }
}
