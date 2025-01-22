import 'package:buzz_chat/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String messageId;
  final String userId;
  final bool isCurrentuser;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentuser,
    required this.messageId,
    required this.userId,
  });

  void _showOptions(BuildContext context, String messageId, String userId) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: Wrap(
              children: [
                //report message button
                ListTile(
                  leading: const Icon(
                    Icons.flag,
                    color: Colors.black,
                  ),
                  title: const Text('Report'),
                  titleTextStyle: const TextStyle(
                    fontFamily: 'QuickSand',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _reportMesage(context, messageId, userId);
                  },
                ),

                //block button
                ListTile(
                  leading: const Icon(
                    Icons.block,
                    color: Colors.black,
                  ),
                  title: const Text('Block User'),
                  titleTextStyle: const TextStyle(
                    fontFamily: 'QuickSand',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _blockMesage(context, userId);
                  },
                ),

                //cancel button
                ListTile(
                  leading: const Icon(
                    Icons.cancel,
                    color: Colors.black,
                  ),
                  title: const Text('Cancel'),
                  titleTextStyle: const TextStyle(
                    fontFamily: 'QuickSand',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          );
        });
  }

// report message
  void _reportMesage(BuildContext context, String messageId, String userId) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text(
                'Report Message',
              ),
              content: const Text(
                'Are you sure you want to report this message?',
              ),
              actions: [
                //cancel button
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancel',
                  ),
                ),

                //report button
                TextButton(
                  onPressed: () {
                    ChatService().reportUser(messageId, userId);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: const Text(
                          'Message Reported',
                          style: TextStyle(
                            fontFamily: 'QuickSand',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                  child: const Text(
                    'Report',
                    style: TextStyle(
                      fontFamily: 'QuickSand',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ));
  }

  //block message
  void _blockMesage(BuildContext context, String userId) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text(
                'Block User',
              ),
              content: const Text(
                'Are you sure you want to Block this User?',
              ),
              actions: [
                //cancel button
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancel',
                  ),
                ),

                //report button
                TextButton(
                  onPressed: () {
                    ChatService().blockUser(userId);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: const Text(
                          'User Blocked',
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                  child: const Text(
                    'Block',
                  ),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    List<Color> gradientColors = [
      Color(0xff401F3E), // Dark grey
      Color(0xff3F2E56), // Medium grey
      Color(0xff453F78),
    ];

    return GestureDetector(
      onLongPress: () {
        if (!isCurrentuser) {
          //show options
          _showOptions(context, messageId, userId);
        }
      },
      child: Align(
        alignment: isCurrentuser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            gradient: isCurrentuser
                ? LinearGradient(
                    colors: gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: isCurrentuser ? null : Colors.grey.shade700,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12),
              topRight: const Radius.circular(12),
              bottomLeft: isCurrentuser
                  ? const Radius.circular(12)
                  : const Radius.circular(0),
              bottomRight: isCurrentuser
                  ? const Radius.circular(0)
                  : const Radius.circular(12),
            ),
          ),
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Text(
            message,
            style: const TextStyle(
              fontFamily: 'QuickSand',
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
