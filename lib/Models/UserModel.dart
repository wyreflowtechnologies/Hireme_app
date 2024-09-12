

class UserModel{

  final String opportunity;
  final String city;
  final String state;
  final String email;
  final String phoneNumber;
  final String whatsappNumber;

  UserModel({required this.opportunity,required this.city,required this.state,required this.email,required this.phoneNumber,required this.whatsappNumber,});


  static UserModel empty() =>
      UserModel(
        opportunity: '',
        city: '',
        state: '',
        email: '',
        phoneNumber: '',
        whatsappNumber: '',
      );

}