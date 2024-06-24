class GetChatModel {
  final uid_opponent;
  final oponent_name;
  final cid;
  final avatar;
  final subject_name;
  final subject_id;
  final last_message;
  final lastMessageTime;
  final type;
  GetChatModel(
      {required this.avatar,
      required this.cid,
      required this.last_message,
      required this.subject_id,
      required this.subject_name,
      required this.uid_opponent,
      required this.oponent_name,
        required this.lastMessageTime,
        required this.type
      });
}
