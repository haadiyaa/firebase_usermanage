import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? username, email, id, phone,password;
  UserModel({
    this.username,
    this.email,
    this.id,
    this.phone,
    this.password,
  });

  
  factory UserModel.fromMap(DocumentSnapshot map) {
    return UserModel(
      id: map.id,
      username: map["username"],
      email: map["email"],
      phone: map["phone"],
      password: map["password"],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      // "id":id,
      "username": username,
      "email": email,
      "phone": phone,
      "password": password,
    };
  }
}
