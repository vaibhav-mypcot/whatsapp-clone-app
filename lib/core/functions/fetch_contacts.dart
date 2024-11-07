import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> uploadContactsToFirestore(
    List<Map<String, dynamic>> contacts) async {
  try {
    CollectionReference contactsRef =
        FirebaseFirestore.instance.collection('contacts');

    for (var contact in contacts) {
      await contactsRef.add(contact);
    }

    print('Contacts uploaded to Firestore successfully.');
    return true;
  } catch (e) {
    print('Error uploading contacts to Firestore: $e');
    return false;
  }
}
