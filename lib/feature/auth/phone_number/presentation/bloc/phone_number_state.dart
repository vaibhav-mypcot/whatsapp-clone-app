part of 'phone_number_bloc.dart';

@immutable
sealed class PhoneNumberState {}

final class PhoneNumberInitial extends PhoneNumberState {}

final class PhoneNumberLoadingState extends PhoneNumberState {}

final class PhoneNumberSuccessState extends PhoneNumberState {}

final class PhoneNumberFailureState extends PhoneNumberState {
  final String error;
  PhoneNumberFailureState({required this.error });
}
