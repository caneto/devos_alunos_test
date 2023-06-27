import 'package:devos_alunos_test/app/core/ui/helpers/context_extension.dart';
import 'package:flutter/material.dart';

class AlunosButton extends StatelessWidget {
  final String label;
  final double? width;
  final double? height;
  final VoidCallback? onPressed;

  const AlunosButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.width,
    this.height = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            foregroundColor: Colors.white,
            backgroundColor: context.primaryColor,
            shape: const StadiumBorder(side: BorderSide.none)),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
