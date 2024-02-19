import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProvider {
  static var fireBaseFireStore = FirebaseFirestore.instance;
  static var collectionUsers = "users";
  static var collectionChatRoom = "chatroom";
  static var collectionMessage = "messages";

  ///login
  ///signup
  ///getUsers

  ///generateChatId
  static String getChatId({
    required String fromId,
    required String toId,
  }) {
    if (fromId.hashCode <= toId.hashCode) {
      return "${fromId}_$toId";
    } else {
      return "${toId}_$fromId";
    }
  }

  ///sendMsg
  static void sendTextMsg(
      {required String fromId, required String toId, required String txtMsg}) {
    var chatId = getChatId(fromId: fromId, toId: toId);

    var currTime = DateTime.now().millisecondsSinceEpoch.toString();

    var msgModel = MessageModel(
        mid: currTime,
        fromId: fromId,
        toId: toId,
        sentAt: currTime,
        txtMsg: txtMsg);

    fireBaseFireStore
        .collection(collectionChatRoom)
        .doc(chatId)
        .collection(collectionMessage)
        .doc(currTime)
        .set(msgModel.toDoc());
  }

  ///sendMsg
  static void sendImageMsg(
      {required String fromId, required String toId, required String imgUrl}) {
    var chatId = getChatId(fromId: fromId, toId: toId);

    var currTime = DateTime.now().millisecondsSinceEpoch.toString();

    var msgModel = MessageModel(
        mid: currTime,
        fromId: fromId,
        toId: toId,
        sentAt: currTime,
        msgType: 1,
        imgUrl: imgUrl);

    fireBaseFireStore
        .collection(collectionChatRoom)
        .doc(chatId)
        .collection(collectionMessage)
        .doc(currTime)
        .set(msgModel.toDoc());
  }

  ///getAllMessages
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      {required String fromId, required String toId}) {
    var chatId = getChatId(fromId: fromId, toId: toId);

    return fireBaseFireStore
        .collection(collectionChatRoom)
        .doc(chatId)
        .collection(collectionMessage)
        .snapshots();
  }

  static updateReadStatus(
      {required String fromId, required String toId, required String mid}) {
    var chatId = getChatId(fromId: fromId, toId: toId);

    var currTime = DateTime.now().millisecondsSinceEpoch.toString();

    return fireBaseFireStore
        .collection(collectionChatRoom)
        .doc(chatId)
        .collection(collectionMessage)
        .doc(mid)
        .update({"readAt" : currTime});
  }
}
