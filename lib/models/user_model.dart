import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? uid;
  String? uName;
  String? uEmail;
  bool? isOnline; // true-> online and false-> offline
  int? accStatus; //1->Active 2->Inactive, 3->Deleted, 4->Suspended
  int? createdAt;

  UserModel(
      {required this.uid,
      required this.uName,
      required this.uEmail,
      this.isOnline = false,
      this.accStatus = 1,
      required this.createdAt});

  factory UserModel.fromDoc(Map<String, dynamic> doc) {
    return UserModel(
        uid: doc['uid'],
        uName: doc['uName'],
        uEmail: doc['uEmail'],
        isOnline: doc['isOnline'],
        accStatus: doc['accStatus'],
        createdAt: doc['createdAt']);
  }

  Map<String, dynamic> toDoc() => {
        'uid': uid,
        'uName': uName,
        'uEmail': uEmail,
        'isOnline': isOnline,
        'accStatus': accStatus,
        'createdAt': createdAt
      };
}
