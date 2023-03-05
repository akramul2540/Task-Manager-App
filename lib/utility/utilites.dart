import 'package:shared_preferences/shared_preferences.dart';

Future<void> WriteUserData(UserData) async {
  final Prefs = await SharedPreferences.getInstance();
  await Prefs.setString('token', UserData['token']);
  await Prefs.setString('email', UserData['data']['email']);
  await Prefs.setString('firstName', UserData['data']['firstName']);
  await Prefs.setString('lastName', UserData['data']['lastName']);
  await Prefs.setString('mobile', UserData['data']['mobile']);
  await Prefs.setString('photo', UserData['data']['photo']);
}

Future<String?> ReadUserData(key) async {
  final Prefs = await SharedPreferences.getInstance();
  String? mydata = await Prefs.getString(key);
  return mydata;
}

Future<void> WriteUserEmailVarification(Email) async {
  final Prefs = await SharedPreferences.getInstance();
  await Prefs.setString('EmailVerification', Email);
}

Future<void> WriteUserOTPVarification(OTP) async {
  final Prefs = await SharedPreferences.getInstance();
  await Prefs.setString('OTPVerification', OTP);
}

Future<bool> RemoveToken() async {
  final Prefs = await SharedPreferences.getInstance();
  await Prefs.remove('token');
  return true;
}
