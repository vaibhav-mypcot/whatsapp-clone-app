part of 'contact_list_bloc.dart';

sealed class ContactListEvent {}

final class ContactListCompareEvent extends ContactListEvent {}
final class ContactListClearEvent extends ContactListEvent {}
