// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../ServerRoutes.dart';
import '../../../data/chat_data_repository.dart';
import 'chat_view.dart';

class ChatListView extends StatelessWidget {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    final chatController = Provider.of<ChatDataRepository>(context);
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    chatController.getChats();
                  },
                  child: Text(
                    'Ваши диалоги',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SingleChildScrollView(
                  child: Column(
                    children:
                        List.generate(chatController.chats.length, (index) {
                      var data = chatController.chats[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: GestureDetector(
                          onTap: () async {
                            await ChatDataRepository().getChats();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OpenChatView(
                                          cid: data.chatId,
                                          chatModel: ChatModel(
                                            model: data.model,
                                              type: data.type,
                                              name: '',
                                              chatId: data.chatId,
                                              createdAt: data.createdAt,
                                              lastMessage: data.lastMessage,
                                              lastMessageSender:
                                                  data.lastMessageSender,
                                              opponentAvatar: '',
                                              opponentFirstName: '',
                                              opponentLastName: '',
                                              opponentNickName: ''),
                                          started: false,
                                          //     subjectName: data.opponentName,
                                        )));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              color: const Color(0xffffffff),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 32,
                                        backgroundImage: NetworkImage(
                                          '${ServerRoutes.host}/avatar?path=avatar_${data.opponentAvatar}',
                                        ),
                                      ),
                                      const SizedBox(width: 14),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.opponentName.toString().trim(),
                                            style: GoogleFonts.inter(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                       '',   //  data.model['age'].toString(),
                                            style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            data.lastMessage == null ||
                                                    data.lastMessage == ''
                                                ? 'Нет сообщений'
                                                : data.lastMessage
                                                            .toString()
                                                            .length >
                                                        15
                                                    ? '${data.lastMessage.toString().substring(0, 15)}...'
                                                    : data.lastMessage
                                                        .toString(),
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff808080),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Text(
                                      data.createdAt.toString().length >
                                              10
                                          ? data.createdAt
                                              .toString()
                                              .substring(10, 16)
                                          : ''),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
