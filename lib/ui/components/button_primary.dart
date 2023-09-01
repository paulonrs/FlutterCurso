import 'package:flutter/material.dart';

class ButtonPrimary extends StatefulWidget {
  // const ButtonPrimary({super.key});
  final String text;
  final VoidCallback function;

  const ButtonPrimary({
    required this.text,
    required this.function,
    super.key,
  });

  @override
  State<ButtonPrimary> createState() {
    return _ButtonPrimaryState();
  }
}

class _ButtonPrimaryState extends State<ButtonPrimary> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: MaterialButton(
        onPressed: () {
          widget.function();
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: const EdgeInsets.all(0.0),
        child: Ink(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment(-1.00, 0.00),
                end: Alignment(1, 0),
                colors: [Color(0xFF4D00B3), Color(0xFF7D19FF)]),
            borderRadius: BorderRadius.all(Radius.circular(80.0)),
          ),
          child: Container(
            constraints: const BoxConstraints(
                minWidth: 88.0,
                minHeight: 62.0), // min sizes for Material buttons
            alignment: Alignment.center,
            child: Text(
              widget.text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
