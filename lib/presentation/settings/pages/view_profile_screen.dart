import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_shop_app/common/helper/firebase_service/firebase_service.dart';
import 'package:my_shop_app/common/helper/navigator/app_navigator.dart';
import 'package:my_shop_app/core/configs/theme/app_colors.dart';
import 'package:my_shop_app/presentation/auth/pages/siginin.dart';
import '../../../common/helper/images/pick_image.dart';
import '../../../domain/auth/entity/user.dart';

class ViewProfileScreen extends StatefulWidget {
  final UserEntity user;
  const ViewProfileScreen({super.key, required this.user});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  File? imageFile;
  void selectImage() async {
    imageFile = await pickImageFromGallery(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(fontSize: 30)),
        backgroundColor: AppColors.background,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Stack(
                    children: [
                      imageFile != null
                          ? CircleAvatar(
                            backgroundImage: FileImage(imageFile!),
                            radius: 100,
                          )
                          : widget.user.image != ''
                          ? CircleAvatar(
                            backgroundImage: NetworkImage(widget.user.image),
                            radius: 100,
                          )
                          : CircleAvatar(
                            backgroundImage: const AssetImage(
                              'assets/images/profile.png',
                            ),
                            radius: 100,
                          ),
                      Positioned(
                        bottom: -5,
                        right: 0,
                        child: IconButton(
                          onPressed: selectImage,
                          icon: const Icon(Icons.add_a_photo_rounded),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(widget.user.email, style: TextStyle(fontSize: 20)),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: widget.user.firstName,
                    onChanged: (value) {
                      widget.user.firstName = value;
                    },
                    style: TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                      hintText: 'Enter your first name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      prefixIcon: Icon(Icons.person, size: 25),
                      label: Text('First Name', style: TextStyle(fontSize: 20)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || value == '') {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: widget.user.lastName,
                    onChanged: (value) {
                      widget.user.lastName = value;
                    },
                    style: TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                      hintText: 'Enter your last name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      prefixIcon: Icon(Icons.person, size: 25),
                      label: Text('Last Name', style: TextStyle(fontSize: 20)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || value == '') {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: widget.user.phoneNumber,
                    onChanged: (value) {
                      widget.user.phoneNumber = value;
                    },
                    style: TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                      hintText: 'Enter your phone number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      prefixIcon: Icon(Icons.phone, size: 25),
                      label: Text(
                        'PhoneNumber',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: widget.user.address,
                    onChanged: (value) {
                      widget.user.address = value;
                    },
                    style: TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                      hintText: 'Enter your address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      prefixIcon: Icon(Icons.location_on, size: 25),
                      label: Text('Address', style: TextStyle(fontSize: 20)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (imageFile != null) {
                          FirebaseService().updateUserDataToFirebase(
                            firstName: widget.user.firstName,
                            lastName: widget.user.lastName,
                            address: widget.user.address,
                            phoneNumber: widget.user.phoneNumber,
                            image: imageFile,
                            context: context,
                          );
                        } else {
                          FirebaseService().updateUserDataToFirebase(
                            firstName: widget.user.firstName,
                            lastName: widget.user.lastName,
                            address: widget.user.address,
                            phoneNumber: widget.user.phoneNumber,
                            context: context,
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(100, 50),
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 140,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        onPressed: signout,
                        child: Row(
                          children: [
                            Icon(Icons.logout, color: Colors.white, size: 25),
                            SizedBox(width: 10),
                            Text(
                              'Logout',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signout() {
    FirebaseAuth.instance.signOut();
    AppNavigator.pushReplacement(context, SigninPage());
  }
}
