import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final SharedPreferencesHelper _instance = SharedPreferencesHelper._ctor();

  factory SharedPreferencesHelper() {
    return _instance;
  }

  SharedPreferencesHelper._ctor();

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }


  static late SharedPreferences _prefs;




  static void setUserPassword({required String userPassword}) {
    _prefs.setString("userpassword", userPassword);
  }

  static String getUserPassword() {
    return _prefs.getString("userpassword") ?? "";
  }

  static void setUserEmail({required String userEmail}) {
    _prefs.setString("useremail", userEmail);
  }

  static String? getUserEmail() {
    return _prefs.getString("useremail");
  }
}
//SharedPreferencesHelper.setUserName(userName: name); =>Set value
//SharedPreferencesHelper.getUserName(); => Retreive value
//_sharedPreferences.getString('lastProfileSelection').toString();
// SharedPreferencesHelper.getUserCity()