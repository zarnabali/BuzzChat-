// ignore_for_file: must_be_immutable

import 'package:buzz_chat/services/auth/auth_service.dart';
import 'package:buzz_chat/core/assets/myButton.dart';
import 'package:buzz_chat/core/assets/my_text_field.dart';
import 'package:buzz_chat/core/assets/password_textField.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class LoginPage extends StatefulWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  //tap function to go to register  page
  void Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();

  Future<void> login(BuildContext context) async {
    final authService = AuthService();
    try {
      print(emailController.text);
      print(passController.text);

      final result = await authService.signInWithEmailPassword(
          emailController.text, passController.text);
      result.fold(
        (error) => _showSnackBar(context, error),
        (success) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success,
              style: const TextStyle(
                fontFamily: 'QuickSand',
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.green,
          ),
        ),
      );
    } catch (e) {
      _showSnackBar(context, e.toString());
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontFamily: 'QuickSand',
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}

class _LoginPageState extends State<LoginPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/login.mp4')
      ..initialize().then((_) {
        setState(() {}); // Update state when the video is initialized
        _controller.play();
        _controller.setLooping(true); // Loop the video
        _controller.setVolume(0); // Mute the video
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background video
          Positioned.fill(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                const Icon(
                  Icons.message,
                  size: 60,
                  color: Colors.white,
                ),
                const SizedBox(height: 5),
                Text(
                  "BuzzChat!",
                  style: GoogleFonts.robotoMono(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                // Welcome back message
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Welcome back, you've been missed!",
                    style: TextStyle(
                        fontFamily: 'QuickSand',
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 50),
                // Email text field
                MyTextField(
                  hintText: 'email',
                  emialController: widget.emailController,
                ),
                const SizedBox(height: 20),
                // Password field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: PasswordField(
                    controller: widget.passController,
                    text: 'password',
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                // Login button
                MyButton(
                  text: 'Login',
                  onTap: () => widget.login(context),
                ),
                const SizedBox(
                  height: 25,
                ),
                // Register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Not a member? ',
                      style: TextStyle(
                          fontFamily: 'QuickSand',
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                          fontFamily: 'QuickSand',
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                          decorationThickness: 2.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
