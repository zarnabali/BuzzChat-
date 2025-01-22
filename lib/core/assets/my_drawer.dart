import 'package:buzz_chat/pages/setting_page.dart';
import 'package:buzz_chat/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    // Get auth service
    final _auth = AuthService();
    _auth.signOut();
  }

// Create route with animation to SettingPage
  Route _createRouteToSettingPage() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const SettingPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Start from the right
        const end = Offset.zero; // End at the natural position
        const curve = Curves.easeInOut; // Define the curve

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // Logo with Gradient Header
              const DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff401F3E), // Dark grey
                      Color(0xff3F2E56), // Medium grey
                      Color(0xff453F78), // Light grey
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: const Icon(
                    Icons.message,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),

              // Home list tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: Text(
                    'H O M E',
                    style: TextStyle(
                      fontFamily: 'QuickSand',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  leading: const Icon(Icons.home),
                  iconColor: Theme.of(context).colorScheme.inversePrimary,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              // Settings list tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: Text(
                    'S E T T I N G S',
                    style: TextStyle(
                      fontFamily: 'QuickSand',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  leading: const Icon(Icons.settings),
                  iconColor: Theme.of(context).colorScheme.inversePrimary,
                  onTap: () {
                    Navigator.push(
                      context,
                      _createRouteToSettingPage(),
                    );
                  },
                ),
              ),
            ],
          ),

          // Logout
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25),
            child: ListTile(
              title: Text(
                'L O G O U T',
                style: TextStyle(
                  fontFamily: 'QuickSand',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              leading: const Icon(Icons.logout),
              iconColor: Theme.of(context).colorScheme.inversePrimary,
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}
