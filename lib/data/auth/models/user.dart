class UserModel {
  String userId;
  String firstName;
  String lastName;
  String? email;
  String? password;
  String? phoneNumber;
  String? address;
  String image;

  UserModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    this.address,
    this.email,
    this.password,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'address': address,
      'email': email,
      'password': password,
      'image': image,
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
      password: map['password'] ?? '',
      image: map['image'] ?? '',
    );
  }
}

