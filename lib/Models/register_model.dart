// user_model.dart

class User {
  String fullName;
  String fatherName;
  Gender gender;
  String email;
  String dob;
  String birthPlace;
  String phone;
  String whatsapp;
  String collegeName;
  String collegeState;
  String branch;
  String degree;
  String passingYear;
  String password;

  User({
    required this.fullName,
    required this.fatherName,
    required this.gender,
    required this.email,
    required this.dob,
    required this.birthPlace,
    required this.phone,
    required this.whatsapp,
    required this.collegeName,
    required this.collegeState,
    required this.branch,
    required this.degree,
    required this.passingYear,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'father_name': fatherName,
      'gender': gender.toString().split('.').last,
      'email': email,
      'date_of_birth': dob,
      'birth_place': birthPlace,
      'phone_number': phone,
      'whatsapp_number': whatsapp,
      'college_name': collegeName,
      'college_state': collegeState,
      'branch_name': branch,
      'degree_name': degree,
      'passing_year': passingYear,
      'password': password,
    };
  }
}

enum Gender { Male, Female, Other }


