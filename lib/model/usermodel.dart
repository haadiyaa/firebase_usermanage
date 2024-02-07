import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? username, email, id, phone, address;
  UserModel({
    this.username,
    this.email,
    this.id,
    this.phone,
    this.address,
  });
  factory UserModel.fromMap(DocumentSnapshot map) {
    return UserModel(
      id: map.id,
      username: map["username"],
      email: map["email"],
      phone: map["phone"],
      address: map["address"],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      // "id":id,
      "username": username,
      "email": email,
      "phone": phone,
      "address": address,
    };
  }
}
