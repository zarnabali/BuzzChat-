import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  final String hintText;
  TextEditingController emialController = TextEditingController();
  MyTextField(
      {required this.emialController, required this.hintText, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: emialController,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.tertiary),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          hintStyle: GoogleFonts.robotoMono(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.normal),
        ),
        style: const TextStyle(
            fontFamily: 'QuickSand',
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.normal),
      ),
    );
  }
}
