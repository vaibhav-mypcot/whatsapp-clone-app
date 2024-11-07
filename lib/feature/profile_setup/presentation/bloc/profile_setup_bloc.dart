import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_clone_app/core/constants/constants.dart';
import 'package:whatsapp_clone_app/feature/auth/verify_number/verify_number_screen.dart';
import 'package:whatsapp_clone_app/init_dependencies.dart';

part 'profile_setup_event.dart';
part 'profile_setup_state.dart';

class ProfileSetupBloc extends Bloc<ProfileSetupEvent, ProfileSetupState> {
  File? pickedImageFile;
  XFile? pickedImage;
  // late final sharedPreferences = serviceLocator<SharedPreferences>();

  ProfileSetupBloc() : super(ProfileSetupInitial()) {
    on<ProfileSetupPickImageEvent>(_onProfileSetupPickImageEvent);
    on<ProfileSetupCreateUserAcEvent>(_onProfileSetupCreateUserAcEvent);
  }

// Event handler for picking an image during profile setup.
  _onProfileSetupPickImageEvent(
      ProfileSetupPickImageEvent event, Emitter<ProfileSetupState> emit) async {
    try {
      if (event.isPickImage) {
        pickedImage =
            await ImagePicker().pickImage(source: ImageSource.gallery);
      } else {
        pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
      }

      final imageTemp = XFile(pickedImage!.path);
      pickedImageFile = File(imageTemp.path);
      emit(ProfileSetupPickedImageState(image: imageTemp));
      debugPrint('image added in list');
    } catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  _onProfileSetupCreateUserAcEvent(ProfileSetupCreateUserAcEvent event,
      Emitter<ProfileSetupState> emit) async {
    emit(ProfileSetupLoadingState());
    // Load an image as ByteData from the assets using the rootBundle.
    ByteData data = await rootBundle.load(Constants.profileImage);
    // Convert the ByteData to a List of unsigned 8-bit integers (List<int>).
    List<int> bytes = data.buffer.asUint8List();

    try {
      final creds = VerifyNumberScreen.globalCredential;

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(creds!);

      final userToken = await userCredential.user!.getIdToken();

      userTokenBox.put('userToken', userToken);

      final token = userTokenBox.get('userToken');

      print("User Token: $token");

      // sharedPreferences.getString(userToken!);

      // Store image in firebase storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('users-profile-pics')
          .child('${userCredential.user!.uid}.jpg');
      if (pickedImage == null) {
        await storageRef.putData(Uint8List.fromList(bytes));
      } else {
        await storageRef.putFile(pickedImageFile!);
      }

      // Get image from firebase storage
      final imageURL = await storageRef.getDownloadURL();

      print("Method called");
      print("${event.userName} \n${event.staus}");

      // Store user information in firebase firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(
        {
          "unique_id": userCredential.user!.uid.toString(),
          "user_name": event.userName.toString(),
          "status": event.staus.toString(),
          "image_url": imageURL,
          "phone_number":
              userCredential.user?.phoneNumber.toString() ?? "1234567890",
          "isOnline": false,   
        },
      );

      // Store logged in users mobile numbers in firestore

      emit(ProfileSetupSuccessState());
    } catch (e) {
      emit(ProfileSetupErrorState(errorMessage: e.toString()));
    }
  }
}
