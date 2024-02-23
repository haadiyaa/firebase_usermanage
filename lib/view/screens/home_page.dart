import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasemain/controller/auth_controller.dart';
import 'package:firebasemain/controller/profilecontroller.dart';
import 'package:firebasemain/view/screens/deleteaccount.dart';
import 'package:firebasemain/view/widgets/text_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetWidget<AuthController> {
  final User? user;

  HomePage(this.user, {super.key});

  final userCollection = FirebaseFirestore.instance.collection("Users");
  final currentUser = FirebaseAuth.instance.currentUser!;

  final ProfileController imagePickerService = ProfileController();

  final TextEditingController newval = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void editField(String fieldName) async {
      String newValue = '';
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Edit $fieldName"),
          content: TextField(
            controller: newval,
            decoration: InputDecoration(
              hintText: "Enter new $fieldName",
              border: const OutlineInputBorder(),
            ),
            onChanged: (value) {
              value = newval.text;
              newValue = value;
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(newValue),
              child: const Text("Save"),
            ),
          ],
        ),
      );

      if (currentUser.email != null && newValue.trim().isNotEmpty) {
        try {
          final docSnapshot = await userCollection.doc(currentUser.email).get();

          if (docSnapshot.exists) {
            await userCollection
                .doc(currentUser
                    .email) // Use currentUser.email as the document ID
                .update({fieldName: newValue});
          } else {
            print('Document does not exist for user: ${currentUser.email}');
          }
        } catch (e) {
          print('Error updating document: $e');
        }
      }
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 241, 241),
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
                      radius: 55,
                      child: Icon(
                        Icons.person,
                        size: 50,
                      ),
                    );
                  }
                  var userr = snapshot.data?.docs.isNotEmpty ?? false
                      ? snapshot.data!.docs[0].data()
                      : null;
                  var imageUrl = (userr as Map<String, dynamic>?)?["image"];

                  return ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    child: imageUrl == null
                        ? const CircleAvatar(
                            radius: 50,
                            child: Icon(
                              Icons.person,
                              size: 55,
                            ),
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
                  imagePickerService.uploadImage(currentUser.email!);
                },
                child: const Text("change profile image")),
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
                          text: userData['name'],
                          sectionName: "User Name",
                          onPressed: () => editField("username"),
                        ),
                        TextBox(
                          text: userData['email'],
                          sectionName: "Email",
                          onPressed: () => editField("email"),
                        ),
                        TextBox(
                          text: userData["phone"],
                          sectionName: "Phone number",
                          onPressed: () {},
                        ),
                        TextBox(
                          text: userData["age"],
                          sectionName: "Age",
                          onPressed: () {},
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            controller.signOut();
                          },
                          child: const Text("Log Out"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.to(() => DeleteAccount());
                          },
                          child: const Text("Delete Account"),
                        ),
                        const SizedBox(height: 20,),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: Text("null"),
                  );
                }
              } else if (snapshot.hasError) {
                return Center(
                    child: Text("Error fetching user data: ${snapshot.error}"));
              } else {
                return const Center(
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
