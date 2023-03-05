import 'package:flutter/material.dart';

class ReusableElevatedButton extends StatelessWidget {
  const ReusableElevatedButton({super.key, required this.onTap, this.text});

  final VoidCallback onTap;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 40,
        child: ElevatedButton(
            onPressed: onTap,
            child: text != null? Text(text?? ''): const Icon(Icons.arrow_circle_right_outlined)));
  }
}
