part of 'profile_setup_bloc.dart';

@immutable
sealed class ProfileSetupState {}

final class ProfileSetupInitial extends ProfileSetupState {}

class ProfileSetupPickedImageState extends ProfileSetupState {
  final XFile image;
  ProfileSetupPickedImageState({required this.image});
}

class ProfileSetupLoadingState extends ProfileSetupState {}

class ProfileSetupSuccessState extends ProfileSetupState {}

class ProfileSetupErrorState extends ProfileSetupState {
  final String errorMessage;
  ProfileSetupErrorState({required this.errorMessage});
}
