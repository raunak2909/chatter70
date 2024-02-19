import 'package:chat_app/Screens/signup_screen.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'chat_screen.dart';

class HomeScreen extends StatefulWidget {
  String userId;
  HomeScreen({required this.userId});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> contactList = [
    /*{
      'image': 'assets/contact_image/person1.jpeg',
      'name': 'Allen',
      'desc': 'Hello!!',
    },
    {
      'image': 'assets/contact_image/person2.jpeg',
      'name': 'Eleanor Pena',
      'desc': 'Hello!!',
    },
    {
      'image': 'assets/contact_image/person3.jpeg',
      'name': 'Bessie Cooper',
      'desc': 'Hello!!',
    },
    {
      'image': 'assets/contact_image/person4.jpeg',
      'name': 'Bessie Cooper',
      'desc': 'Hello!!',
    },
    {
      'image': 'assets/contact_image/person5.jpeg',
      'name': 'Bessie Cooper',
      'desc': 'Hello!!',
    },*/

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 15),
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
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                    itemCount: contactList.length,
                    itemBuilder: (_,index){
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.grey.withOpacity(.9),width: 2)
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.asset(contactList[index]['image'],fit: BoxFit.cover,),),
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30))
                ),
                child: Column(
                  children: [
                  const SizedBox(height: 15,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("All", style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.grey),),
                    Text("Unread", style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.grey),),
                    Text("Archived", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.grey),),
                  ],
                ),
                const SizedBox(height: 20,),
                Expanded(child: FutureBuilder(
                  future: FirebaseFirestore.instance.collection(SignupScreen.COLLECTION_PATH).get(),
                  builder: (_, snapshot){
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if(snapshot.hasData){
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (_, index) {
                            var eachUser = UserModel.fromDoc(snapshot.data!.docs[index].data());
                            if(eachUser.uid!=widget.userId) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 5),
                                child: ListTile(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            ChatScreen(currUserId: widget.userId, eachUserId: eachUser.uid!, name: eachUser.uName!,))
                                      );
                                    },
                                    leading: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          color: Colors.black
                                      ),
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(60),
                                          child: Image.asset(
                                            'assets/contact_image/person5.jpeg',
                                            fit: BoxFit.fitHeight,)),
                                    ),
                                    title: Text(eachUser.uName!,
                                      style: const TextStyle(fontSize: 20,
                                          fontWeight: FontWeight.bold),),
                                    subtitle: Text(eachUser.uEmail!),
                                    /*trailing: Column(
                                      children: [
                                        *//*const Text('12:00 AM'),*//*
                                        const SizedBox(height: 5,),
                                        Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  10),
                                              color: Colors.deepPurpleAccent
                                          ),
                                          child: const Center(child: Text('1',
                                            style: TextStyle(
                                                color: Colors.white),)),
                                        )
                                      ],
                                    )*/
                                ),
                              );
                            } else {
                              return Container();
                            }
                          });
                    } else {
                      return Center(
                        child: Text('No Users Found!!'),
                      );
                    }
                  },
                )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


