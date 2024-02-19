import 'package:chat_app/firebase_provider.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen(
      {required this.currUserId, required this.eachUserId, required this.name});

  String currUserId;
  String eachUserId;
  String name;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var sendMsgController = TextEditingController();
  bool hasContent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios_new)),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Chat Box',
                    style: GoogleFonts.roboto(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(45),
                        child: Image.asset(
                          'assets/contact_image/person1.jpeg',
                          fit: BoxFit.cover,
                        )),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    widget.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Colors.white),
                    child: Icon(
                      Icons.call,
                      color: Colors.deepPurpleAccent,
                      size: 25,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Colors.white),
                    child: Icon(
                      Icons.video_call_rounded,
                      color: Colors.deepPurpleAccent,
                      size: 30,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ///view all msg
            Expanded(
              child: Container(
                width: double.infinity,
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseProvider.getAllMessages(fromId: widget.currUserId, toId: widget.eachUserId),
                  builder: (_, snapshot){
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                        itemBuilder: (_, index){
                      var eachMsgModel = MessageModel.fromDoc(snapshot.data!.docs[index].data());

                      if(eachMsgModel.fromId==widget.currUserId){
                        return rightMessageBubble(eachMsgModel);
                      } else {
                        return leftMessageBubble(eachMsgModel);
                      }
                    });
                  },
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                    color: Colors.white),
              ),
            ),

            ///send msg
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.3),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.shade200),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: sendMsgController,
                              onChanged: (text) {
                                setState(() {
                                  hasContent = text.isNotEmpty;
                                });
                              },
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Say Something...',
                                  hintStyle: TextStyle(
                                    fontFamily:
                                        GoogleFonts.manrope().fontFamily,
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Icon(
                              Icons.account_circle,
                              color: Colors.grey.shade700,
                              size: 21,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 11),
                  hasContent
                      ? InkWell(
                          onTap: () {
                            FirebaseProvider.sendTextMsg(
                                fromId: widget.currUserId,
                                toId: widget.eachUserId,
                                txtMsg: sendMsgController.text.toString());
                            sendMsgController.text = "";
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 21,
                            ),
                          ),
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Icon(
                            Icons.mic,
                            color: Colors.white,
                            size: 21 / 1.2,
                          ),
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  ///fromId
  Widget rightMessageBubble(MessageModel msg){

    var sentTime = TimeOfDay.fromDateTime(
        DateTime.fromMillisecondsSinceEpoch(int.parse(msg.sentAt!)));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(sentTime.format(context)),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.all(11),
                padding: EdgeInsets.all(11),
                decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(21),
                        topRight: Radius.circular(21),
                        bottomLeft: Radius.circular(21))),
                child: msg.msgType == 0 ? Text(msg.txtMsg) : Image.network(msg.imgUrl!),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(visible: msg.readAt!="",
                      child: Text(msg.readAt=="" ? "" : TimeOfDay.fromDateTime(
                          DateTime.fromMillisecondsSinceEpoch(int.parse(msg.readAt!))).format(context).toString())),
                  SizedBox(
                    width: 7,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.done_all_outlined,
                      color: msg.readAt!= "" ? Colors.blue : Colors.grey,),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
  ///toId
  Widget leftMessageBubble(MessageModel msg){

    if(msg.readAt==""){
      FirebaseProvider.updateReadStatus(fromId: widget.currUserId, toId: widget.eachUserId, mid: msg.mid!);
    }

    var sentTime = TimeOfDay.fromDateTime(
        DateTime.fromMillisecondsSinceEpoch(int.parse(msg.sentAt!)));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(11),
                padding: EdgeInsets.all(11),
                decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(21),
                        topRight: Radius.circular(21),
                        bottomLeft: Radius.circular(21))),
                child: msg.msgType == 0 ? Text(msg.txtMsg) : Image.network(msg.imgUrl!),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(sentTime.format(context)),
        ),

      ],
    );
  }
}
