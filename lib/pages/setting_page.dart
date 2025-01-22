import 'package:buzz_chat/themes/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xff401F3E), // Dark grey
                Color(0xff3F2E56), // Medium grey
                Color(0xff453F78), // Light grey
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(36),
              bottomRight: Radius.circular(36),
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7, // Blur radius for a softer shadow
                offset: const Offset(0, 3), // Offset the shadow downward
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors
                .transparent, // Make AppBar transparent to see the gradient
            centerTitle: true,
            elevation: 0, // Remove AppBar's default shadow
            title: const Text(
              'Settings',
              style: TextStyle(
                fontFamily: 'GeneralSans',
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: Colors.white,
              ),
            ),
            iconTheme: const IconThemeData(
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            //dark mode
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dark Mode",
                  style: TextStyle(
                    fontFamily: 'GeneralSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                Consumer<ThemeProvider>(
                  builder: (context, themeProvider, child) {
                    return CupertinoSwitch(
                      value: themeProvider.isdarkMode,
                      onChanged: (value) => themeProvider.toggleTheme(),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(
              color:
                  Theme.of(context).colorScheme.inversePrimary.withOpacity(0.5),
              thickness: 1.0,
            ),

            //blocked users
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Blocked Users",
                    style: TextStyle(
                      fontFamily: 'GeneralSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  Icon(
                    Icons.arrow_circle_right,
                    size: 50,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Divider(
              color:
                  Theme.of(context).colorScheme.inversePrimary.withOpacity(0.5),
              thickness: 1.0,
            ),
          ],
        ),
      ),
    );
  }
}
