import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_clone_app/core/services/shared_preferences_service.dart';
import 'package:whatsapp_clone_app/feature/auth/phone_number/presentation/bloc/phone_number_bloc.dart';
import 'package:whatsapp_clone_app/feature/contacts/presentation/bloc/contact_list_bloc.dart';
import 'package:whatsapp_clone_app/feature/dashboard/pages/chats/presentation/bloc/chat_bloc.dart';
import 'package:whatsapp_clone_app/feature/profile_setup/presentation/bloc/profile_setup_bloc.dart';

final serviceLocator = GetIt.instance;
final contactListBox = Hive.box();
final userTokenBox = Hive.box();

Future<void> initDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  serviceLocator.registerLazySingleton<SharedPreferencesService>(
    () => SharedPreferencesService(sharedPreferences),
  );

  _initPhoneNumber();
  _initContactList();
  _initProfileSetup();
  _initChat();
}

void _initPhoneNumber() {
  // Bloc
  serviceLocator.registerLazySingleton<PhoneNumberBloc>(
    () => PhoneNumberBloc(),
  );
}

void _initContactList() {
  // Bloc
  serviceLocator.registerLazySingleton<ContactListBloc>(
    () => ContactListBloc(),
  );
}

void _initProfileSetup() {
  // Bloc
  serviceLocator.registerLazySingleton<ProfileSetupBloc>(
    () => ProfileSetupBloc(),
  );
}

void _initChat() {
  // Bloc
  serviceLocator.registerLazySingleton<ChatBloc>(
    () => ChatBloc(),
  );
}
