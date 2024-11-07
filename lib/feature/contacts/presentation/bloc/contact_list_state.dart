part of 'contact_list_bloc.dart';

sealed class ContactListState {}

final class ContactListInitial extends ContactListState {}

final class ContactListLoadingState extends ContactListState {}

final class ContactListSuccessState extends ContactListState {
  final List<Map<String, String>> contactsOnApp;
  ContactListSuccessState(
    this.contactsOnApp,
  );
}

final class ContactListFailureState extends ContactListState {
  final String errorMessage;
  ContactListFailureState(this.errorMessage);
}

final class ContactListClearState extends ContactListState {}
