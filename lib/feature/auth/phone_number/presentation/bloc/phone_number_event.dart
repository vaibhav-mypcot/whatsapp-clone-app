part of 'phone_number_bloc.dart';

@immutable
sealed class PhoneNumberEvent {}

final class PhoneNumberVerificationEvent extends PhoneNumberEvent {
  final String phoneNumber;
  final BuildContext context;
  PhoneNumberVerificationEvent(this.phoneNumber, this.context);
}

final class PhoneNumbersFetchEvent extends PhoneNumberEvent {}
