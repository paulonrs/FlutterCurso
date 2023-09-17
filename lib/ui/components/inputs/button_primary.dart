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
              begin: Alignment.bottomLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 78, 0, 179),
                Color.fromARGB(255, 89, 5, 197),
                Color.fromARGB(255, 102, 15, 217),
                Color.fromARGB(255, 118, 24, 233),
                Color.fromARGB(255, 130, 35, 255),
              ],
              stops: [0.1, 0.2, 0.6, 0.8, 1],
            ),
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
