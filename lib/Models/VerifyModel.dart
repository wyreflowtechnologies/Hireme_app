// user_profile.dart
class Verifymodel {
  final String id;
  final String fullName;
  final String fatherName;
  final String email;
  final String dateOfBirth;
  final String birthPlace;
  final String gender;
  //final String phoneNumber;
  //final String whatsappNumber;

  Verifymodel({
    required this.id,
    required this.fullName,
    required this.fatherName,
    required this.email,
    required this.dateOfBirth,
    required this.birthPlace,
    required this.gender,
   // required this.phoneNumber,
    //required this.whatsappNumber,

  });

  factory Verifymodel.fromJson(Map<String, dynamic> json) {
    return Verifymodel(
      id: json['id'].toString(),
      fullName: json['full_name'] ?? '',
      fatherName: json['father_name'] ?? '',
      email: json['email'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      birthPlace: json['birth_place'] ?? '',
      gender: json['gender'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'father_name': fatherName,
      'email': email,
      'date_of_birth': dateOfBirth,
      'birth_place': birthPlace,
      'gender': gender,
    };
  }
}
