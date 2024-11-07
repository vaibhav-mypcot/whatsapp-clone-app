import 'package:cloud_firestore/cloud_firestore.dart';

class ContactListModel {
  final String id;
  final String name;
  final String phoneNumber;
  final String imageUrl;
  final bool isOnline;

  ContactListModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.imageUrl,
    required this.isOnline,
  });

  // Create a factory method to convert Firestore document to YourModel
  factory ContactListModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return ContactListModel(
      id: doc.id,
      name: data['user_name'] ?? '',
      phoneNumber: data['phone_number'] ?? '',
      imageUrl: data['image_url'] ?? '',
      isOnline: data['isOnline'] ?? false,
    );
  }
}
