// import 'dart:typed_data';

// import 'package:fast_contacts/fast_contacts.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

// class ContactsPage extends StatefulWidget {
//   const ContactsPage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _ContactsPageState createState() => _ContactsPageState();
// }

// class _ContactsPageState extends State<ContactsPage> {
//   List<Contact> _contacts = [];

//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchContacts();
//   }

//   Future<void> _fetchContacts() async {
//     if (await Permission.contacts.request().isGranted) {
//       try {
//         List<Contact> contacts = await FastContacts.getAllContacts();
//         List<Map<String, dynamic>> contactList = [];

//         for (var contact in contacts) {
//           // Get image for each contact

//           if (contact.phones.isNotEmpty) {
//             contactList.add({
//               'name': contact.displayName,
//               'phoneNumber': contact.phones.first.number,
//             });
//           }
//         }

//         setState(() {
//           _contacts = contacts;
//           _isLoading = false;
//         });
//       } catch (e) {
//         print('Error fetching contacts: $e');
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     } else {
//       print('Permission denied');
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Contacts'),
//         ),
//         body: _isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : ListView.builder(
//                 itemCount: _contacts.length,
//                 itemBuilder: (context, index) {
//                   final contact = _contacts[index];
//                   return ListTile(
//                     title: Text(contact.displayName),
//                     subtitle: contact.phones.isNotEmpty
//                         ? Text(contact.phones.first.toString())
//                         : const Text('No phone number'),
//                   );
//                 },
//               ));
//   }
// }
