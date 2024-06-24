import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/chat_data_repository.dart';
import '../../../domain/user/auth/create_user.dart';

TextEditingController _messageController = TextEditingController();
class OpenChatView extends StatefulWidget {
  final String cid;
  final ChatModel? chatModel;
  bool started;
  OpenChatView({Key? key, required this.cid, required this.chatModel, required this.started}) : super(key: key);

  @override
  State<OpenChatView> createState() => _OpenChatViewState();
}

class _OpenChatViewState extends State<OpenChatView> {
  ScrollController _scrollController = ScrollController();

  final TextEditingController _messageController = TextEditingController();

  void _scrollToBottom(double pos) {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + pos,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 1),
      );
    }}

  @override
  Widget build(BuildContext context) {
    final chat = Provider.of<ChatDataRepository>(context);
    _scrollToBottom(300);
    if (widget.started==false) {
      chat.startChat(widget.cid);

      widget.started = true;
    }
    return WillPopScope(
      onWillPop: ()async{
        chat.getChats();
        Navigator.pop(context);
        return false;
      },

      child: Scaffold(
     //   backgroundColor: themeData.scaffoldBackgroundColor,
        appBar: AppBar(
          iconTheme: IconThemeData(
           // color: themeData.colorScheme.surface,
          ),
          centerTitle: true,
          // title: Row(
          //   children: [
          //     widget.  chatModel?.opponentAvatar !=''  ? CircleAvatar(
          //       radius: 22,
          //       backgroundImage:
          //       NetworkImage( widget.chatModel?.opponentAvatar),
          //     )
          //         : CircleAvatar(
          //       radius: 22,
          //       child: Center(
          //         child: Text( firstCharsNameParser(
          //             widget.  chatModel?.opponentFirstName,
          //             widget.  chatModel?.opponentLastName)),
          //       ),
          //     ),
           //   const SizedBox(width: 4,),
          ////    Text(widget.chatModel!.opponentName ?? '', style: themeData.textTheme.titleLarge,),
           // ],
          ),
        //  backgroundColor: themeData.scaffoldBackgroundColor,

        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: chat.messages.length,
                itemBuilder: (context, index) {
                  var item = chat.messages[index];
                  return Align(
                    alignment: uid == item['uid'] ? Alignment.centerRight : Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 1.5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(item['text'],),
                              Text(item['created_at']!= null ?item['created_at'].toString().substring(10,16) :'',)
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
               // color: themeData.colorScheme.primaryContainer,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                   //     style: themeData.textTheme.titleMedium,
                        controller: _messageController,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        chat.sendMessage(widget.cid, _messageController.text);
                        _messageController.clear();
                        // Прокрутка вниз после отправки сообщения
                        _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent +300,
                          duration: const Duration(milliseconds: 1),
                          curve: Curves.easeOut,
                        );
                      },
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                       //   color: themeData.colorScheme.surface,
                        ),
                        child: Center(
                        //  child: Icon(Icons.send, color: themeData.colorScheme.primary,),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void initState() {
    widget.started == false ?  WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom(30000)) :null;
    super.initState();
  }
}
