class UserModel {
  final int? id;
  final String name;
  final String email;
  final String password;
  final String? profession;
  final String? phone;

  UserModel({this.id, required this.name, required this.email, required this.password,this.phone,this.profession});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'profession': profession,
      'phone': phone,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      phone: map['phone'],
      profession: map['profession'],
    );
  }
}
