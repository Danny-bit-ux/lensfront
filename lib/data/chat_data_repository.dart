import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../ServerRoutes.dart';
import '../domain/user/auth/create_user.dart';

class ChatDataRepository with ChangeNotifier {
  Dio dio = Dio();
  List messages = [];
  List<ChatModel> chats = [];
  WebSocket? socket;
  Future<void> startChat(cid) async {
    socket = await WebSocket.connect(ServerRoutes.chatWS);

    var joinMessage = jsonEncode({'action': 'join', 'cid': cid});
    socket?.add(joinMessage);
    notifyListeners();
    socket?.listen((dynamic data) {
      messages = jsonDecode(data);
      notifyListeners();
    }, onError: (error) {}, onDone: () {});
    notifyListeners();
  }

  Future<void> sendMessage(cid, message) async {
    socket?.add(jsonEncode({
      'cid': cid,
      'text': message,
      'uid': uid,
      'created_at': DateTime.now().toString(),
    }));
  }

  Future<String> createChat(type, admin, List uids, subject) async {
    final response =
        await dio.post('${ServerRoutes.chatHttp}/createChat', data: {
      'type': '0',
      'admin': admin,
      'users': uids,
      'subject': subject,
    });
    return jsonDecode(response.data)['chat_id'].toString();
  }

  Future<void> getChats() async {
    final response = await dio.post("${ServerRoutes.chatHttp}/getChats", data: {
      'uid': uid,
    });
    chats.clear();
    var data = jsonDecode(response.data);
    for (var item in data) {
      final responsePlayer =
          await dio.get("${ServerRoutes.host}/getuserdata", data: {
        'id': int.parse(
            '${item['opponents'][0] == uid ? item['opponents'][1] : item['opponents'][0]}')
      });
      var model;
      if (item['type'] == '0') {
        final response = await dio.post('${ServerRoutes.host}/getAd', data: {
          'id': item['subject'],
        });
        model = jsonDecode(response.data);
      }
      chats.add(
          ApiChat.fromApi(item, jsonDecode(responsePlayer.data), model).chat);
      notifyListeners();
    }
  }
}

class ChatModel {
  var chatId;
  var lastMessage;
  var createdAt;
  var name;
  var opponentFirstName;
  var opponentLastName;
  var opponentNickName;
  final opponentAvatar;
  var lastMessageSender;
  var model;
  var type;
  ChatModel(
      {required this.name,
      required this.chatId,
      required this.createdAt,
      required this.lastMessage,
      required this.lastMessageSender,
      required this.opponentAvatar,
      required this.opponentFirstName,
      required this.opponentLastName,
      required this.opponentNickName,
      required this.model,
      required this.type});
  get opponentName => opponentNickName == null || opponentNickName == ''
      ? '$opponentLastName $opponentFirstName'
      : opponentNickName;
}

class ApiChat {
  final ChatModel chat;
  ApiChat.fromApi(Map<String, dynamic> map, opponent, model)
      : chat = ChatModel(
          name: map['name'],
          chatId: map['id'],
          createdAt: map['created_at'],
          lastMessage: map['message'],
          lastMessageSender: map['message_sender'],
          opponentAvatar: opponent['uid'], //opponent['avatarURL'] ?? '',
          opponentFirstName: opponent['name'],
          opponentLastName: '', //opponent['name']['last'],
          opponentNickName: '', // opponent['name']['nick']);
          type: map['type'],
          model: model,
        );
}
