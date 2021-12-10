import 'package:flutter/material.dart';
import 'package:meuapp/shared/theme/app_text.dart';
import 'package:meuapp/shared/theme/app_theme.dart';

class InputText extends StatelessWidget {
  final String label;
  final String hint;
  final bool obscure;
  final String? Function(String)? validator;
  final void Function(String)? onChanged;
  const InputText({
    required this.label,
    required this.hint,
    this.obscure = false,
    this.onChanged,
    this.validator,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label).label,
        const SizedBox(height: 12),
        TextFormField(
          obscureText: obscure,
          onChanged: onChanged,
          validator: (value) {
            if (value != null) {
              return validator!(value);
            }
          },
          style: AppTheme.textStyles.input,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTheme.textStyles.hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1.5, color: AppTheme.colors.border),
            ),
          ),
        ),
      ],
    );
  }
}
