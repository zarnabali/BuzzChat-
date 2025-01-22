// ignore_for_file: must_be_immutable

import 'package:buzz_chat/services/auth/auth_service.dart';
import 'package:buzz_chat/core/assets/myButton.dart';
import 'package:buzz_chat/core/assets/my_text_field.dart';
import 'package:buzz_chat/core/assets/password_textField.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class RegisterPage extends StatefulWidget {
  void Function()? onTap;

  RegisterPage({required this.onTap, super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late VideoPlayerController _controller;

  void register() async {
    // Create auth service
    final _auth = AuthService();

    // If password and confirm password match
    if (widget.passController.text == widget.confirmPassController.text) {
      final result = await _auth.signUpWithEmailAndPassword(
          widget.emailController.text, widget.passController.text);

      result.fold(
        (errorMessage) {
          // Show error snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                errorMessage,
                style: const TextStyle(
                  fontFamily: 'QuickSand',
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.red,
            ),
          );
        },
        (successMessage) {
          // Show success snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                successMessage,
                style: const TextStyle(
                  fontFamily: 'QuickSand',
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.green,
            ),
          );
        },
      );
    } else {
      // Show password mismatch snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Passwords don't match!",
            style: TextStyle(
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

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/register.mp4')
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

          Container(
            child: Center(
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
                  const Text(
                    "BuzzChat!",
                    style: TextStyle(
                        fontFamily: 'QuickSand',
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  // Welcome back message
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Let's create an account for you",
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
                  const SizedBox(height: 20),

                  //confirm password field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: PasswordField(
                      controller: widget.confirmPassController,
                      text: 'confirm password',
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // Login button
                  MyButton(
                    text: 'Register',
                    onTap: register,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // Register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account? ',
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
                          'Login now',
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
