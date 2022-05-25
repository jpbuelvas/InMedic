import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:inmedic/constants.dart';
import 'package:inmedic/domain/chat_provider.dart';
import 'package:inmedic/main.dart';
import 'package:inmedic/screens/chat/top_bar.dart';
import 'package:inmedic/screens/widgets/custom_chat_list_view_tile.dart';
import 'package:inmedic/screens/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class ChatView extends StatefulWidget {
  ChatView({Key? key, required this.chatId}) : super(key: key);
  final String chatId;
  @override
  State<ChatView> createState() => ChatViewState();
}

class ChatViewState extends State<ChatView> {
  TextEditingController _textController = TextEditingController();

  late ScrollController _messagesListViewController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _messagesListViewController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChatPageProvider>(
          create: (_) =>
              ChatPageProvider(widget.chatId, _messagesListViewController),
        ),
      ],
      child: Builder(builder: (BuildContext context) {
        final provider = Provider.of<ChatPageProvider>(context);
        return (provider.messages == null)
            ? Container(child: Loading())
            : GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Scaffold(
                  body: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Container(
                      height: media.height,
                      width: media.width,
                      color: KColor.lightGreenBackground,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            color: KColor.darkGreenBackground,
                            child: TopBar(
                              "${widget.chatId}",
                              fontSize: 25,
                              secondaryAction: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: KColor.darkBlueText,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 9,
                            child: ListView.builder(
                              controller: _messagesListViewController,
                              itemCount: provider.messages?.length,
                              itemBuilder: (BuildContext context, int index) {
                                bool isOwnMessage =
                                    provider.messages![index].senderID ==
                                        KUIds.mainUserUId;
                                return CustomChatListViewTile(
                                    width: media.width / 2,
                                    deviceHeight: media.height,
                                    isOwnMessage: isOwnMessage,
                                    message: provider.messages![index]);
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              // color: Colors.green,
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: Container(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: CustomTextFormField(
                                          controller: _textController,
                                          onSaved: (_value) {
                                            provider.message = _value;
                                          },
                                          regEx: r"^(?!\s*$).+",
                                          hintText: "Type a message",
                                          obscureText: false),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                          child: _sendMessageButton(
                                              media, provider))),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
      }),
    );
  }

  Widget _sendMessageButton(Size media, ChatPageProvider provider) {
    double _size = media.height * 0.08;
    return Container(
      height: _size,
      width: _size,
      child: IconButton(
        icon: Icon(
          Icons.send,
          color: KColor.darkBlueText,
        ),
        onPressed: () {
          debugPrint("## message");
          // if (_messageFormState.currentState!.validate()) {
          debugPrint("## messages recived: ${provider.messages?.length}");
          FocusScope.of(context).unfocus();
          provider.message = _textController.text;
          provider.sendTextMessage();
          provider.message = null;
          _textController.text = "";
          //   _messageFormState.currentState!.reset();
          // }
        },
      ),
    );
  }
}



// Widget _messagesListView() {
//   if (_pageProvider != null) {
//     if (_pageProvider.messages!.length != 0) {
//       return Container(
//         height: _deviceHeight * 0.74,
//         child: ListView.builder(
//           controller: _messagesListViewController,
//           itemCount: _pageProvider.messages!.length,
//           itemBuilder: (BuildContext _context, int _index) {
//             ChatMessage _message = _pageProvider.messages![_index];
//             bool _isOwnMessage = _message.senderID == _auth.user.uid;
//             return Container(
//               child: CustomChatListViewTile(
//                 deviceHeight: _deviceHeight,
//                 width: _deviceWidth * 0.80,
//                 message: _message,
//                 isOwnMessage: _isOwnMessage,
//                 sender: this
//                     .widget
//                     .chat
//                     .members
//                     .where((_m) => _m.uid == _message.senderID)
//                     .first,
//               ),
//             );
//           },
//         ),
//       );
//     } else {
//       return Align(
//         alignment: Alignment.center,
//         child: Text(
//           "Be the first to say Hi!",
//           style: TextStyle(color: Colors.white),
//         ),
//       );
//     }
//   } else {
//     return Center(
//       child: CircularProgressIndicator(
//         color: Colors.white,
//       ),
//     );
//   }
// }
