class User {
  String? firstname;
  String? lastname;
  String? email;
  String? phone;

  User({this.firstname, this.lastname, this.email, this.phone});

  User.fromMap(Map<String, dynamic> data) {
    firstname = data['first name'];
    lastname = data['last name'];
    email = data['email'];
    phone = data['phone'];
  }

  Map<String, dynamic> toMap() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'phone': phone,
    };
  }
}