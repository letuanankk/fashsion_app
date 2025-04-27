import '/../../domain/auth/entity/user.dart';

class UserModel {
  String userId;
  String firstName;
  String lastName;
  String? email;
  String? phoneNumber;
  String? address;
  String image;
  int? gender;

  UserModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    this.address,
    this.email,
    required this.image,
    this.gender,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'address': address,
      'email': email,
      'image': image,
      'gender': gender,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] ?? '',
      address: map['address'] ?? '',
      image: map['image'] ?? '',
      gender: map['gender'] as int,
    );
  }
}

extension UserXModel on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      address: address,
      email: email!,
      image: image,
      gender: gender!,
    );
  }
}
