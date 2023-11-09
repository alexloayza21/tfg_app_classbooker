import 'package:flutter/material.dart';

class AsientoButton extends StatefulWidget {
  AsientoButton({super.key, this.colorButton, this.onTap, required this.isSelected});
  final Color? colorButton;
  final VoidCallback? onTap;
  final bool isSelected;



  @override
  State<AsientoButton> createState() => _AsientoButtonState();
}

class _AsientoButtonState extends State<AsientoButton> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: 42,
          width: 70,
          decoration: BoxDecoration(
            color: widget.colorButton?.withAlpha(50),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Icon(
              widget.isSelected ? Icons.chair : Icons.chair_outlined,
              key: ValueKey<bool>(widget.isSelected),
              color: widget.colorButton,
            )),
        )
      ),
    );
  }

}