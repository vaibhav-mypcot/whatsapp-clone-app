import 'package:bloc/bloc.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp_clone_app/core/functions/fetch_contacts.dart';
import 'package:whatsapp_clone_app/core/services/shared_preferences_service.dart';
import 'package:whatsapp_clone_app/feature/auth/verify_number/verify_number_screen.dart';
import 'package:whatsapp_clone_app/init_dependencies.dart';

part 'phone_number_event.dart';
part 'phone_number_state.dart';

class PhoneNumberBloc extends Bloc<PhoneNumberEvent, PhoneNumberState> {
  List<Contact> _contacts = [];
  late final sharedPrefsService = serviceLocator<SharedPreferencesService>();

  PhoneNumberBloc() : super(PhoneNumberInitial()) {
    on<PhoneNumberVerificationEvent>(_onPhoneNumberVerificationEvent);
    on<PhoneNumbersFetchEvent>(_onPhoneNumbersFetchEvent);
  }

  _onPhoneNumberVerificationEvent(PhoneNumberVerificationEvent event,
      Emitter<PhoneNumberState> emit) async {
    emit(PhoneNumberLoadingState());
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: event.phoneNumber,
        verificationCompleted: (phoneAuthCredential) {},
        verificationFailed: (error) {
          print(error.toString());
        },
        codeSent: (verificationId, forceResendingToken) {
          Navigator.pushNamed(
            event.context,
            VerifyNumberScreen.route,
            arguments: {'verificationId': verificationId},
          );
        },
        codeAutoRetrievalTimeout: (verificationId) {
          print("Auto retrieval timeout");
        },
      );
      emit(PhoneNumberSuccessState());
    } catch (e) {
      emit(PhoneNumberFailureState(error: e.toString()));
    }
  }

  _onPhoneNumbersFetchEvent(
      PhoneNumbersFetchEvent event, Emitter<PhoneNumberState> emit) async {
    emit(PhoneNumberLoadingState());

    if (await Permission.contacts.request().isGranted) {
      try {
        List<Contact> contacts = await FastContacts.getAllContacts();
        List<Map<String, dynamic>> contactList = [];
        // List<String> contactList = [];

        for (var contact in contacts) {
          if (contact.phones.isNotEmpty) {
            contactList.add({
              'name': contact.displayName.toString(),
              'phone':
                  contact.phones.first.number.replaceAll(' ', '').toString(),
            });
          }
        }
        contactListBox.put('contactList', contactList);
        // sharedPrefsService.saveUsersContacts(contacts);

        print("Length of the contact list: ${contactList.length}");
        emit(PhoneNumberSuccessState());
        // Now upload to Firestore
        // bool isUploadContactsToFirestore =
        //     await uploadContactsToFirestore(contactList);
        // if (isUploadContactsToFirestore) {
        //   emit(PhoneNumberSuccessState());
        // } else {
        //   emit(PhoneNumberFailureState(
        //       error: "Phone numbers not uploded to firebase"));
        // }
      } catch (e) {
        print('Error fetching contacts: $e');
        emit(PhoneNumberFailureState(error: e.toString()));
      }
    } else {
      print('Permission denied');
    }
  }
}
