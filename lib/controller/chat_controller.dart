import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../ServerRoutes.dart';
import '../domain/user/auth/create_user.dart';
import '../model/get_chat_model.dart';
import '../model/message_model.dart';

class ChatController extends GetxController {
  Dio dio = Dio();
  RxString type = '0'.obs;
  final messages = Rx<List<MessageModel>>([]);
  final chats = Rx<List<GetChatModel>>([]);
  Future<int> createChat(
      {required uid1, required uid2, required pid, required type}) async {
    await getUserChats(type);

    for (GetChatModel item in chats.value) {
      if (item.subject_id.toString() == pid.toString() && item.type.toString() == type.toString()) {
        print('bgfdfgfd');
        print(item.cid);
        return int.parse(item.cid);
      }
    }
    final response = await dio.post('${ServerRoutes.host}/createchat', data: {
      'type': type,
      'uid1': uid1.toString(),
      'uid2': uid2.toString(),
      'chat_subject': pid.toString(),
    });
    print('333bgfdfgfd');
    return int.parse(jsonDecode(response.data).toString());
  }

  Future<void> getChatMessages(cid) async {
    final response = await dio.post('${ServerRoutes.host}/getmessages',
        data: {'cid': cid.toString()});
    messages.value.clear();
    List msgs = jsonDecode(response.data);
    for (int i = 0; i < msgs.length; i++) {
      messages.value.add(MessageModel(
          uid: msgs[i]['uid'],
          pid: msgs[i]['pid'],
          msg_text: msgs[i]['msg_text'],
          createdAt: msgs[i]['creates_at']));
    }
    notifyChildrens();
  }

  void clearList() {
    messages.value.clear();
    notifyChildrens();
  }

  Future<void> getUserChats(String type) async {
    final response = await dio.post('${ServerRoutes.host}/getchats', data: {
      'uid': uid.toString(),
    });
    chats.value.clear();
    List data = jsonDecode(response.data);
    for (int i = 0; i < data.length; i++) {
           data[i]['type'] == type
              ? chats.value.add(GetChatModel(
                  avatar: '',
                  cid: data[i]['cid'],
                  last_message: data[i]['last_message'],
                  subject_id: data[i]['chat_subject'],
                  subject_name: data[i]['subject_name'],
                  uid_opponent: data[i]['uid_opponent'],
                  oponent_name: data[i]['opponent_name'].toString(),
                  lastMessageTime: data[i]['last_messate_time'],
                  type: data[i]['type']))
              : null;

      chats.refresh();
      notifyChildrens();
    }
  }

  Future<void> sendMessage({
    required cid,
    required uid,
    required msg,
  }) async {
    final response = await dio.post('${ServerRoutes.host}/sendmessage', data: {
      'cid': cid.toString(),
      'uid': uid.toString(),
      'msg': msg.toString(),
    });
  }

  void changeChatType(
    _type,
  ) {
    type.value = _type;
    getUserChats(_type);
    notifyChildrens();
  }
}
