import 'package:chat_app/Screens/signup_screen.dart';
import 'package:chat_app/widgets/uihelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'homescreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.9),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Log in",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Email",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 15,
                ),
                UiHelper.CustomTextField(
                    emailController, "Enter your Email..", Icons.mail, false),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 15,
                ),
                UiHelper.CustomTextField(passController,
                    "Enter your Password..", Icons.password, true),
                const SizedBox(
                  height: 55,
                ),
                Center(
                  child: Container(
                    height: 55,
                    width: 300,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurpleAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () async{

                          var mAuth = FirebaseAuth.instance;
                          try {
                            var userCred = await mAuth
                                .signInWithEmailAndPassword(
                                email: emailController.text.toString(),
                                password: passController.text.toString());

                            ///store userID in shared pref

                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(userId: userCred.user!.uid),));

                          }on FirebaseAuthException catch(exception){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Error: ${exception.message}")));
                          }catch(e){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Internet Connection")));
                          }


                        },
                        child: const Text(
                          "Log in",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen(),));
                    }, child: const Text("Sign up"))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
