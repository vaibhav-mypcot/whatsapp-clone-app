import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_app/core/services/shared_preferences_service.dart';
import 'package:whatsapp_clone_app/feature/auth/verify_number/verify_number_screen.dart';
import 'package:whatsapp_clone_app/feature/contacts/data/model/contact_list_model.dart';
import 'package:whatsapp_clone_app/feature/dashboard/pages/chats/data/model/user_model.dart';
import 'package:whatsapp_clone_app/init_dependencies.dart';

part 'contact_list_event.dart';
part 'contact_list_state.dart';

class ContactListBloc extends Bloc<ContactListEvent, ContactListState> {
  List<ContactListModel> itemsList = [];
  List<Map<String, String>> matchingContacts = [];
  List contactList = contactListBox.get('contactList', defaultValue: []);

  ContactListBloc() : super(ContactListInitial()) {
    on<ContactListCompareEvent>(_onContactListCompareEvent);
    on<ContactListClearEvent>(_onContactListClearEvent);
  }

  _onContactListClearEvent(
      ContactListClearEvent event, Emitter<ContactListState> emit) {
    matchingContacts.clear();
    print("List is cleared");
  }

  _onContactListCompareEvent(
      ContactListCompareEvent event, Emitter<ContactListState> emit) async {
    // final List contactsOnApp;

    emit(ContactListLoadingState());

    try {
      CollectionReference collectionRef =
          FirebaseFirestore.instance.collection('users');

      // Fetch the documents
      QuerySnapshot querySnapshot = await collectionRef.get();

      itemsList.clear();

      //Convert documents to YourModel and add to the list
      for (var doc in querySnapshot.docs) {
        itemsList.add(ContactListModel.fromFirestore(doc));
      }

      for (int i = 0; i < itemsList.length; i++) {
        for (int k = 0; k < contactList.length; k++) {
          final phoneContacts = contactList[k]['phone'];
          final serverContact = itemsList[i].phoneNumber;
          if (phoneContacts == serverContact) {
            matchingContacts.add({
              'name': itemsList[i].name,
              'phoneNumber': itemsList[i].phoneNumber,
              'imageUrl': itemsList[i].imageUrl,
              'reciverId': itemsList[i].id,
            });
          }
        }
      }

      for (int i = 0; i < itemsList.length; i++) {
        final contact = itemsList[i];
        print("name: ${contact.name}");
        print("name: ${contact.phoneNumber}");
      }

      emit(ContactListSuccessState(matchingContacts));

      // List to hold contacts with matching phone numbers
      // List<Map<String, String>> matchingContacts = [];

      // // Convert Firestore documents to ContactListModel and compare
      // for (var doc in querySnapshot.docs) {
      //   final firestoreContact = ContactListModel.fromFirestore(doc);

      //   // Check if any item in contactList matches the firestoreContact's phone number
      //   final isMatch = contactList.any((contact) {
      //     // Replace 'phoneNumber' with the actual key for phone number in contactList
      //     return contact.phones.first.number == firestoreContact.phoneNumber;
      //   });

      //   print("phoneNumber: ${firestoreContact.phoneNumber}");

      //   // If a match is found, add the name and phone number to matchingContacts
      //   if (isMatch) {
      //     matchingContacts.add({
      //       'name': firestoreContact.name,
      //       'phoneNumber': firestoreContact.phoneNumber
      //     });
      //   }
      // }

      // Now matchingContacts contains only the items with matching phone numbers
      // print("Matching Contacts: $matchingContacts");
      // emit(ContactListSuccessState(matchingContacts, contactList));
    } catch (e) {
      ContactListFailureState(e.toString());
    }
  }
}
