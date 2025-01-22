import 'package:flutter/material.dart';

List<Color> gradient = [
  const Color(0xff1a73e8),
  Color(0xff4285f4),
  Color(0xff8ab4f8),
  Color(0xff8ab4f8),
  Color(0xff4285f4),
  Color(0xff6841ea),
  Color(0xffea4335),
  Color(0xfff28b82)
];

class GradientText extends StatelessWidget {
  GradientText(
    this.text, {
    super.key,
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }
}
