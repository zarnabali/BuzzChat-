import 'package:buzz_chat/core/assets/user_tile.dart';
import 'package:buzz_chat/pages/chat_page.dart';
import 'package:buzz_chat/services/auth/auth_service.dart';
import 'package:buzz_chat/core/assets/my_drawer.dart';
import 'package:buzz_chat/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void logout() {
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(36),
              bottomLeft: Radius.circular(36),
            ),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.tertiary,
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: AppBar(
                backgroundColor: Colors.black,
                centerTitle: true,
                title: const Text(
                  'Home',
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
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff401F3E),
                        Color(0xff3F2E56),
                        Color(0xff453F78),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        drawer: MyDrawer(),
        body: _builtUserList());
  }

  Widget _builtUserList() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _chatService.getUserStreamExcludingBlocked(),
        builder: (context, snapshot) {
          //error
          if (snapshot.hasError) {
            return const SnackBar(
              content: Text(
                "Error",
                style: TextStyle(
                  fontFamily: 'QuickSand',
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.red,
            );
          }

          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          }

          //list view
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .secondary, // Set the background color of the container
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(36), // Curve top-left corner
                topRight: Radius.circular(36), // Curve top-right corner
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.tertiary,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(36),
                topRight: Radius.circular(36),
              ),
              child: ListView(
                children: snapshot.data!
                    .map<Widget>(
                      (userData) => _buildUserListItem(userData, context),
                    )
                    .toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          Navigator.push(
            context,
            _createChatRoute(userData["email"], userData["uid"]),
          );
        },
      );
    } else {
      return Container();
    }
  }

// Method to create a custom route with animation to ChatPage
  Route _createChatRoute(String receiverEmail, String receiverID) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ChatPage(
        receiverEmail: receiverEmail,
        receiverID: receiverID,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0); // Start from the right
        var end = Offset.zero; // End at the natural position
        var curve = Curves.easeInOut; // Define the curve

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
}
