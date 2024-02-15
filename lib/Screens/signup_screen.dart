import 'package:chat_app/Screens/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/uihelper.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final String COLLECTION_PATH = 'users';

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
                  "Sign up",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Name",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 15,
                ),
                UiHelper.CustomTextField(nameController, "Enter your Name..",
                    Icons.drive_file_rename_outline, false),
                const SizedBox(
                  height: 15,
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
                        onPressed: () async {
                          var mAuth = FirebaseAuth.instance;
                          try {
                            var userCred = await mAuth
                                .createUserWithEmailAndPassword(
                                email: emailController.text.toString(),
                                password: passController.text.toString());

                            var mFireStore = FirebaseFirestore.instance;

                            mFireStore.collection(COLLECTION_PATH).doc(userCred.user!.uid).set({
                              "name" : nameController.text.toString(),
                             "email" :  emailController.text.toString(),
                              "password" : passController.text.toString(),
                            });
                          }on FirebaseAuthException catch(e){
                            if(e.code=='weak-password'){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("The password provided is too weak")));
                            }else if(e.code=='email-already-in-use'){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("The account already exists for that email.")));
                            }
                          }catch(e){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Internet Connection")));

                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ));
                        },
                        child: const Text(
                          "Sign up",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
