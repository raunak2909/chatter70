import 'package:firebase_auth/firebase_auth.dart';

class MessageModel {
  String? mid;
  String? fromId;
  String? toId;
  String? sentAt;
  String? readAt;
  String txtMsg;
  int? msgType; //0->txt, 1->image
  String? imgUrl;

  MessageModel(
      {required this.mid,
      required this.fromId,
      required this.toId,
      required this.sentAt,
      this.readAt = "",
      this.txtMsg = "",
      this.msgType = 0,
      this.imgUrl = ""});

  factory MessageModel.fromDoc(Map<String, dynamic> doc) {
    return MessageModel(
        mid: doc['mid'],
        fromId: doc['fromId'],
        toId: doc['toId'],
        sentAt: doc['sentAt'],
        readAt: doc['readAt'],
        txtMsg: doc['txtMsg'],
        msgType: doc['msgType'],
        imgUrl: doc['imgUrl']);
  }

  Map<String, dynamic> toDoc() => {
        'mid': mid,
        'fromId': fromId,
        'sentAt': sentAt,
        'toId': toId,
        'readAt': readAt,
        'txtMsg': txtMsg,
        'msgType': msgType,
        'imgUrl': imgUrl,
      };
}
