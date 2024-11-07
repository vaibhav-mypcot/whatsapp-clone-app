part of 'profile_setup_bloc.dart';

@immutable
sealed class ProfileSetupEvent {}

class ProfileSetupPickImageEvent extends ProfileSetupEvent {
  final bool isPickImage;
  ProfileSetupPickImageEvent(this.isPickImage);
}

class ProfileSetupCreateUserAcEvent extends ProfileSetupEvent {
  final String userName;
  final String staus;

  ProfileSetupCreateUserAcEvent({
    required this.userName,
    required this.staus,
  });
}

// class ProfileSetupTakeImageEvent extends ProfileSetupEvent {
//   final bool isTakeImage;
//   ProfileSetupTakeImageEvent(this.isTakeImage);
// }


//userCredential.user?.phoneNumber.toString() ??  "",