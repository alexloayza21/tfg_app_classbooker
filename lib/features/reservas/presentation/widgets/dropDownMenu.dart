// ignore: unused_element, must_be_immutable
// ignore_for_file: file_names

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DropDownMenu extends StatelessWidget {
  DropDownMenu({
    super.key, 
    required this.horas,
    required this.textStyle,
    required this.horaSelected
  });

  final List<String> horas;
  final TextTheme textStyle;
  late String? horaSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color(0xff0017FF).withOpacity(0.07)
      ),
      child: DropdownButtonFormField(
        items: horas.map((hora) {
          return DropdownMenuItem(
            value: hora,
            child: Center(child: Text(hora, style: textStyle.bodyMedium,)),
          );
        }).toList(),
        onChanged: (value) {
          horaSelected = value;
        },
        icon: const Icon(Icons.access_time_outlined),
        
      ),
    );
  }
}