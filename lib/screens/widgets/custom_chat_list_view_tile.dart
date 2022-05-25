import 'package:flutter/material.dart';
import 'package:inmedic/constants.dart';
import 'package:inmedic/data/models/chat_user.dart';

import '../../data/models/chat_message.dart';

class CustomChatListViewTile extends StatelessWidget {
  final double width;
  final double deviceHeight;
  final bool isOwnMessage;
  final ChatMessage message;
  // final ChatUser sender;

  CustomChatListViewTile({
    required this.width,
    required this.deviceHeight,
    required this.isOwnMessage,
    required this.message,
    // required this.sender,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      width: width,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment:
            isOwnMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: width * 0.05,
          ),
          Container(
            width: width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: (!isOwnMessage)
                    ? KColor.darkBlueText
                    : KColor.darkGreenBackground),
            padding: EdgeInsets.all(20),
            margin: (isOwnMessage) ? EdgeInsets.only(right: 10) : null,
            child: Text(
              message.content,
              maxLines: 10,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
