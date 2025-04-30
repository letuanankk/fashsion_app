import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/auth_controller.dart';
import '/../../common/helper/navigator/app_navigator.dart';
import '/../../common/widgets/appbar/app_bar.dart';
import '/../../common/widgets/button/basic_app_button.dart';
import '/../../data/auth/models/user_creation_req.dart';
import 'siginin.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignupPage extends ConsumerWidget {
  SignupPage({super.key});

  final TextEditingController _firstNameCon = TextEditingController();
  final TextEditingController _lastNameCon = TextEditingController();
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const BasicAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 40
      ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _siginText(),
            const SizedBox(height: 20,),
            _firstNameField(),
            const SizedBox(height: 20,),
            _lastNameField(),
            const SizedBox(height: 20,),
            _emailField(),
            const SizedBox(height: 20,),
            _passwordField(context),
            const SizedBox(height: 20,),
            _continueButton(context, ref),
            const SizedBox(height: 20,),
            _createAccount(context)
          ],
        ),
      ),
    );
  }

  Widget _siginText() {
    return const Text(
      'Create Account',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold
      ),
    );
  }

  Widget _firstNameField() {
    return TextField(
      controller: _firstNameCon,
      decoration: const InputDecoration(
        hintText: 'Firstname'
      ),
    );
  }

  Widget _lastNameField() {
    return TextField(
      controller: _lastNameCon,
      decoration: const InputDecoration(
        hintText: 'Lastname'
      ),
    );
  }

  Widget _emailField() {
    return TextField(
      controller: _emailCon,
      decoration: const InputDecoration(
        hintText: 'Email Address'
      ),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _passwordCon,
      decoration: const InputDecoration(
        hintText: 'Password'
      ),
    );
  }

  Widget _continueButton(BuildContext context, WidgetRef ref) {
    return BasicAppButton(
      onPressed: (){
        UserCreationReq user = UserCreationReq(
          firstName: _firstNameCon.text,
          lastName: _lastNameCon.text,
          email: _emailCon.text,
          password: _passwordCon.text
        );
        ref.read(authControllerProvider).signup(context, user);
      },
      title: 'Continue'
    );
  }

  Widget _createAccount(BuildContext context) {
    return RichText(
      text: TextSpan(
        children:  [
          const TextSpan(
            text: "Do you have an account? "
          ),
           TextSpan(
            text: 'Signin',
            recognizer:TapGestureRecognizer()..onTap = () {
              AppNavigator.pushReplacement(context, SigninPage());
            } ,
            style: const TextStyle(
              fontWeight: FontWeight.bold
            )
          )
        ]

      ),
    );
  }
}