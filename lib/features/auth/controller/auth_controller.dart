import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_shop_app/data/auth/models/user.dart';

import '../../../data/auth/models/user_creation_req.dart';
import '../../../data/auth/models/user_signin_req.dart';
import '../repository/auth_repository.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository, ref: ref);
});

final userDataAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getUser();
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;
  AuthController({required this.authRepository, required this.ref});

  Future<UserModel?> getUser() async {
    var doc = authRepository.getCurrentUserData();
    return doc;
  }

  Future<UserModel?> getCurrentUserData() async {
    return await authRepository.getCurrentUserData();
  }

  void signup(BuildContext context,UserCreationReq user) {
    authRepository.signup(context,user);
  }

  void signin(BuildContext context,UserSigninReq user) {
    authRepository.signin(context,user);
  }

  void signout() {
    authRepository.signout();
  }

  void sendPasswordResetEmail(String email) {
    authRepository.sendPasswordResetEmail(email);
  }

  Future<bool> isLoggedIn() async {
    return await authRepository.isLoggedIn();
  }

  Stream<UserModel> getUserData(String userId) {
    return authRepository.userData(userId);
  }
}
