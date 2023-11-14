import 'package:flutter/material.dart';
import 'package:tfg_app/config/config.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key, 
    this.isTopField = false, 
    this.isBottomField = false, 
    this.label, 
    this.hint, 
    this.errorMessage, 
    this.obscureText = false, 
    this.keyboardType = TextInputType.text, 
    this.initialValue = '', 
    this.onChanged, 
    this.onFieldSubmitted, 
    this.validator,
  });

  final bool isTopField;
  final bool isBottomField;
  final String? label;
  final String? hint;
  final String? errorMessage;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String initialValue;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;


  @override
  Widget build(BuildContext context) {

  final border = OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: Colors.transparent));
  final errorBorder = OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: Colors.red));
  const borderRadius = Radius.circular(15);
  final color = AppTheme().colorSeed;

    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8, bottom: (errorMessage != null) ? 10 : 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: isTopField ? borderRadius : Radius.zero,
            topRight: isTopField ? borderRadius : Radius.zero,
            bottomLeft: isBottomField ? borderRadius : Radius.zero,
            bottomRight: isBottomField ? borderRadius : Radius.zero
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(0, 5)
            )
          ]
        ),
        child: TextFormField(
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          validator: validator,
          obscureText: obscureText,
          keyboardType: keyboardType,
          initialValue: initialValue,
          style: const TextStyle(fontSize: 15, color: Colors.black),
          onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
          decoration: InputDecoration(
            enabledBorder: border,
            focusedBorder: border,
            errorBorder: errorBorder,
            focusedErrorBorder: errorBorder,
            hintText: hint,
            label: (label != null) ? Text(label!, style: TextStyle(color: color),) : null,
            errorText: errorMessage,
            focusColor: Colors.red
          ),
        )
      ),
    );
  }
}