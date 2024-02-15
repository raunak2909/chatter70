import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
   ChatScreen({super.key,required this.image,required this.name});

  String image;
  String name;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
              const SizedBox(height: 20,),
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
                          child: Image.asset(widget.image,fit: BoxFit.cover,)),
                    ),
                    SizedBox(width: 15,),
                    Text(widget.name, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40,color: Colors.white),),
                    SizedBox(
                      width: 100,
                    ),
                    Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Colors.white
                      ),
                      child: Icon(Icons.call,color: Colors.deepPurpleAccent,size: 25,),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          color: Colors.white
                      ),
                      child: Icon(Icons.video_call_rounded,color: Colors.deepPurpleAccent,size: 30,),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30,),
              Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30),),
                  color: Colors.white
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
