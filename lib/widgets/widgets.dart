import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {super.key, required this.child, this.elevation, this.color, this.ontap });

  final Widget child;
  final double? elevation;
  final Color? color;
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ontap ?? (){},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.zero,
      ),
      child: child,
    );
  }
}