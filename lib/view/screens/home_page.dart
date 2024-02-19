import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebasemain/controller/auth_controller.dart';
import 'package:firebasemain/controller/profilecontroller.dart';
import 'package:firebasemain/view/screens/deleteaccount.dart';
import 'package:firebasemain/view/widgets/text_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends GetWidget<AuthController> {
  final User? user;


  HomePage(this.user, {super.key});

  final userCollection = FirebaseFirestore.instance.collection("Users");
  final currentUser = FirebaseAuth.instance.currentUser!;

  final ProfileController imagePickerService = ProfileController();

  @override
  Widget build(BuildContext context) {
    void editField(String fieldName) async {
      String newValue = '';
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Edit $fieldName"),
          content: TextField(
            decoration: InputDecoration(
              hintText: "Enter new $fieldName",
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              newValue = value;
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(newValue),
              child: Text("Save"),
            ),
          ],
        ),
      );
      //updating in firestore
      // if(newValue.trim().length>0){
      //   await userCollection.doc(currentUser.email).update({field:newValue});
      // }
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 241, 241),
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .where("email", isEqualTo: user!.email)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                    );
                  }
                  var userr = snapshot.data?.docs.isNotEmpty ?? false
                      ? snapshot.data!.docs[0].data()
                      : null;
                  var imageUrl=(userr as Map<String,dynamic>?)?["image"];


                  return ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    child: imageUrl == null
                        ? const Image(
                          width: 90,
                          height: 90,
                            fit: BoxFit.cover,
                            image: AssetImage("assets/profile.webp"),
                          )
                        : Image(
                          width: 90,
                          height: 90,
                            fit: BoxFit.cover,
                            image: NetworkImage(imageUrl),
                          ),
                  );
                }),
          ),
          const SizedBox(
            height: 5,
          ),
          Center(
            child: TextButton(
                onPressed: () {
                  print("image change");
                  imagePickerService.uploadImage(currentUser.email!);
                },
                child: Text("change profile image")),
          ),
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .doc(user!.uid)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData) {
                final userData = snapshot.data?.data() as Map<String, dynamic>?;
                if (userData != null) {
                  return Expanded(
                    child: ListView(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            "My Details",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        TextBox(
                          text: userData['name'] ?? '',
                          sectionName: "username",
                          onPressed: () => editField("username"),
                        ),
                        TextBox(
                          text: userData['email'] ?? '',
                          sectionName: "email",
                          onPressed: () => editField("email"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            controller.signOut();
                          },
                          child: Text("Log Out"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.to(() => DeleteAccount());
                          },
                          child: const Text("Delete Account"),
                        ),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     controller.google_signOut();
                        //   },
                        //   child: const Text("Google Sign Out"),
                        // ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Text("null"),
                  );
                }
              } else if (snapshot.hasError) {
                return Center(
                    child: Text("Error fetching user data: ${snapshot.error}"));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
