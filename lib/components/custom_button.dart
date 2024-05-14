import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? onClick;
  final String text;

  const CustomButton({
    super.key,
    required this.onClick,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.all(7),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(25)
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18
            ),
          )
        )
      ),
    );
  }
}
