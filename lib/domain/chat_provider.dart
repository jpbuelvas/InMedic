import 'dart:async';

//Packages
import 'package:flutter/material.dart';
import 'package:inmedic/constants.dart';
import 'package:inmedic/data/data_service/data_service.dart';
import 'package:inmedic/data/models/chat_message.dart';

//Services

//Providers

//Models

class ChatPageProvider extends ChangeNotifier {
  late DatabaseService _db;
  // late CloudStorageService _storage;
  // late MediaService _media;
  // late NavigationService _navigation;

  ScrollController _messagesListViewController;

  String _chatId;
  List<ChatMessage>? messages;

  late StreamSubscription _messagesStream;
  late StreamSubscription _keyboardVisibilityStream;
  // late KeyboardVisibilityController _keyboardVisibilityController;

  String? message;

  // String get message {
  //   return message;
  // }

  // void set message(String _value) {
  //   _message = _value;
  // }

  ChatPageProvider(this._chatId, this._messagesListViewController) {
    _db = DatabaseService();
    // _storage = GetIt.instance.get<CloudStorageService>();
    // _media = GetIt.instance.get<MediaService>();
    // _navigation = GetIt.instance.get<NavigationService>();
    // _keyboardVisibilityController = KeyboardVisibilityController();
    listenToMessages();
    // listenToKeyboardChanges();
  }

  @override
  void dispose() {
    _messagesStream.cancel();
    super.dispose();
  }

  void listenToMessages() {
    try {
      _messagesStream = _db.streamMessagesForChat(_chatId).listen(
        (_snapshot) {
          List<ChatMessage> _messages = _snapshot.docs.map(
            (_m) {
              Map<String, dynamic> _messageData =
                  _m.data() as Map<String, dynamic>;
              return ChatMessage.fromJSON(_messageData);
            },
          ).toList();
          messages = _messages;
          notifyListeners();
          WidgetsBinding.instance!.addPostFrameCallback(
            (_) {
              if (_messagesListViewController.hasClients) {
                _messagesListViewController.animateTo(
                    _messagesListViewController.position.maxScrollExtent,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.bounceIn);
              }
            },
          );
        },
      );
    } catch (e) {
      print("Error getting messages.");
      print(e);
    }
  }

  // void listenToKeyboardChanges() {
  //   _keyboardVisibilityStream = _keyboardVisibilityController.onChange.listen(
  //     (_event) {
  //       _db.updateChatData(_chatId, {"is_activity": _event});
  //     },
  //   );
  // }

  void sendTextMessage() {
    debugPrint("## message: $message");
    if (message != null) {
      ChatMessage _messageToSend = ChatMessage(
        content: message!,
        type: MessageType.TEXT,
        senderID: KUIds.mainUserUId,
        sentTime: DateTime.now(),
      );
      _db.addMessageToChat(_chatId, _messageToSend);
    }
  }

  // void sendImageMessage() async {
  //   try {
  //     PlatformFile? _file = await _media.pickImageFromLibrary();
  //     if (_file != null) {
  //       String? _downloadURL = await _storage.saveChatImageToStorage(
  //           _chatId, _auth.user.uid, _file);
  //       ChatMessage _messageToSend = ChatMessage(
  //         content: _downloadURL!,
  //         type: MessageType.IMAGE,
  //         senderID: _auth.user.uid,
  //         sentTime: DateTime.now(),
  //       );
  //       _db.addMessageToChat(_chatId, _messageToSend);
  //     }
  //   } catch (e) {
  //     print("Error sending image message.");
  //     print(e);
  //   }
  // }

  // void deleteChat() {
  //   goBack();
  //   _db.deleteChat(_chatId);
  // }

  // void goBack() {
  //   _navigation.goBack();
  // }
}
