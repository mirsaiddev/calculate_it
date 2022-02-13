import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);

  final String title;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.grey[900]),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
