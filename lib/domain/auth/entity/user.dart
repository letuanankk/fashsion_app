class UserEntity {
  String userId;
  String firstName;
  String lastName;
  String email;
  String image;
  String? phoneNumber;
  String? address;
  int gender;

  UserEntity({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.address,
    this.phoneNumber,
    required this.image,
    required this.gender,
  });
}
