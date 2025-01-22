import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MessageTextField extends StatelessWidget {
  final String hintText;
  TextEditingController emialController = TextEditingController();
  final FocusNode? focusNode;
  MessageTextField(
      {required this.emialController,
      required this.hintText,
      super.key,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), // Rounded corners
          gradient: const RadialGradient(
            colors: [
              Color(0xff401F3E), // Dark grey
              Color(0xff3F2E56), // Medium grey
              Color(0xff453F78), // Light grey
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0), // Padding for the gradient border
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(context)
                  .colorScheme
                  .secondary, // Background color inside the gradient
            ),
            child: TextField(
              focusNode: focusNode,
              controller: emialController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                hintText: hintText,
                hintStyle: TextStyle(
                    fontFamily: 'QuickSand',
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.normal),
              ),
              style: TextStyle(
                  fontFamily: 'QuickSand',
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ),
    );
  }
}
