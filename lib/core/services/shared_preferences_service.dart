import 'package:fast_contacts/fast_contacts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _sharedPreferences;

  SharedPreferencesService(this._sharedPreferences);

  // Future<void> saveUserToken(String user) async {
  //   await _sharedPreferences.setString("userToken", user);
  // }

  // String? getUserToken() {
  //   return _sharedPreferences.getString("userToken");
  // }

  // Future<void> saveUsersContacts(List<Contact> usersPhoneNumber) async {
  //   await _sharedPreferences.setStringList("phoneNumbers", usersPhoneNumber);
  // }

  // List<String>? getUsersContactsList() {
  //   return _sharedPreferences.getStringList("phoneNumbers");
  // }

  // deleteContactList() async {
  //   return _sharedPreferences.remove("phoneNumbers");
  // }
}
