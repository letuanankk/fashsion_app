import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:my_shop_app/data/auth/models/user.dart';
import '../images/pick_image.dart';

class FirebaseService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<String> storeFileToFirebase(String ref, File file) async {
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  void saveUserDataToFirebase(
    String firstName,
    String lastName,
    File? image,
    BuildContext context,
  ) async {
    try {
      String uid = auth.currentUser!.uid;
      String photoUrl = '';

      if (image != null && image.path != '') {
        photoUrl = await storeFileToFirebase('profilePic/$uid/$uid', image);
      }

      var user = UserModel(
        userId: uid,
        firstName: firstName,
        lastName: lastName,
        image: photoUrl,
      );

      await firebaseFirestore.collection('Users').doc(uid).set(user.toMap());
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void updateUserDataToFirebase({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? address,
    File? image,
    required BuildContext context,
  }) async {
    try {
      String uid = auth.currentUser!.uid;
      String photoUrl = '';

      if (image != null && image.path != '') {
        photoUrl = await storeFileToFirebase('profilePic/$uid/$uid', image);
        await firebaseFirestore.collection('Users').doc(uid).update({
          'firstName': firstName,
          'lastName': lastName,
          'phoneNumber': phoneNumber,
          'address': address,
          'image': photoUrl,
        });
      } else {
        await firebaseFirestore.collection('Users').doc(uid).update({
          'firstName': firstName,
          'lastName': lastName,
          'phoneNumber': phoneNumber,
          'address': address,
        });
      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
