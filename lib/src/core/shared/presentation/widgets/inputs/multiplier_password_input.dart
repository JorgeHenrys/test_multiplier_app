import 'package:flutter/material.dart';
import 'package:test_multiplier_app/src/core/core.dart';

class MultiplierPasswordInput extends StatefulWidget {
  final String label;
  final String? helperText;
  final String? errorText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool disabled;
  final bool loading;
  final Function()? onTap;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  const MultiplierPasswordInput({
    super.key,
    required this.label,
    this.helperText,
    this.errorText,
    this.validator,
    this.onTap,
    this.onChanged,
    this.disabled = false,
    this.loading = false,
    this.controller,
    this.focusNode,
  });

  @override
  State<MultiplierPasswordInput> createState() => _MultiplierPasswordInput();
}

class _MultiplierPasswordInput extends State<MultiplierPasswordInput> {
  bool isPasswordHidden = true;
  void setVisibility() {
    setState(() {
      isPasswordHidden = !isPasswordHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    Icon visibilityIcon = Icon(
      isPasswordHidden
          ? Icons.remove_red_eye_outlined
          : Icons.remove_red_eye_outlined,
      color: Colors.grey,
    );

    return MultiplierBaseInput(
      label: widget.label,
      onTap: widget.onTap,
      loading: widget.loading,
      disabled: widget.disabled,
      controller: widget.controller,
      focusNode: widget.focusNode,
      validator: widget.validator,
      helperText: widget.helperText,
      errorText: widget.errorText,
      onChanged: widget.onChanged,
      autocorrect: false,
      enableSuggestions: false,
      obscureText: isPasswordHidden,
      suffixIcon: IconButton(icon: visibilityIcon, onPressed: setVisibility),
    );
  }
}
