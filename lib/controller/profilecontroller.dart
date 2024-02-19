import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  Future<void> uploadImage(String email) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      try {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();

        Reference referenceRoot = FirebaseStorage.instance.ref();
        Reference referenceDirImages = referenceRoot.child("images");
        Reference referenceImageToUpload = referenceDirImages.child(fileName);

        await referenceImageToUpload.putFile(File(file.path));
        String imageUrl = await referenceImageToUpload.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('Users')
            .where('email', isEqualTo: email)
            .get()
            .then((querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            doc.reference.update({'image': imageUrl});
          });
        });

        Get.snackbar('Image Uploaded', 'Image uploaded successfully!');

      } catch (e) {

        print("error uploading image");
        Get.snackbar('Error', 'Failed to upload image. Please try again.');

      }
    }

  
  }
}
