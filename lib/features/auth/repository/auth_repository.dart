import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_shop_app/common/helper/navigator/app_navigator.dart';
import 'package:my_shop_app/data/auth/models/user_signin_req.dart';
import 'package:my_shop_app/features/home/pages/home.dart';
import '../../../data/auth/models/user.dart';
import '../../../data/auth/models/user_creation_req.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRepository({required this.auth, required this.firestore});

  Future<UserModel?> getCurrentUserData() async {
    var userData =
        await firestore.collection('Users').doc(auth.currentUser?.uid).get();

    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }

  Future<String?> signup(BuildContext context, UserCreationReq user) async {
    try {
      var returnedData = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: user.email!,
            password: user.password!,
          );

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(returnedData.user!.uid)
          .set({
            'firstName': user.firstName,
            'lastName': user.lastName,
            'email': user.email,
            'image': returnedData.user!.photoURL ?? '',
            'userId': returnedData.user!.uid,
          });
      AppNavigator.pushReplacement(
        context,
        HomePage(userId: returnedData.user!.uid),
      );
      // Đăng ký thành công, không trả về lỗi
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'An account already exists with that email.';
      } else {
        return 'Authentication error: ${e.message}';
      }
    } catch (e) {
      // Bắt các lỗi khác không liên quan đến FirebaseAuth
      return 'An unexpected error occurred: $e';
    }
  }

  Future<String?> signin(BuildContext context, UserSigninReq user) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );
      AppNavigator.pushReplacement(
        context,
        HomePage(userId: FirebaseAuth.instance.currentUser!.uid),
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return 'No user found for this email.';
      } else if (e.code == 'invalid-credential') {
        return 'Wrong password provided for this user.';
      } else {
        return 'Authentication error: ${e.message}';
      }
    } catch (e) {
      return 'An unexpected error occurred: $e';
    }
  }

  Future<void> signout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<String?> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return null; // Thành công
    } catch (e) {
      return 'Please try again';
    }
  }

  Future<bool> isLoggedIn() async {
    return FirebaseAuth.instance.currentUser != null;
  }

  Stream<UserModel> userData(String userId) {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .snapshots()
        .map((event) => UserModel.fromMap(event.data()!));
  }
}
