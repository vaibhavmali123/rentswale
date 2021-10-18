import 'package:rentswale/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Database {
  static SharedPreferences sharedPreferences;

  static initDatabase() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static addTocart(String json) async {
    await sharedPreferences.setString(constants.cartKey, json);
  }

  static String getCart() {
    return sharedPreferences.getString(constants.cartKey);
  }

  static deleteCart() {
    return sharedPreferences.setString(constants.cartKey, "");
  }

  static setUserName(String userName) async {
    await sharedPreferences.setString(constants.userName, userName);
  }

  static String getUserName() {
    return sharedPreferences.getString(constants.userName);
  }

  static setName(String name) async {
    await sharedPreferences.setString(constants.name, name);
  }

  static String getName() {
    return sharedPreferences.getString(constants.name);
  }

  static setUserId(String userId) async {
    await sharedPreferences.setString(constants.userId, userId);
  }

  static String getUserId() {
    return sharedPreferences.getString(constants.userId);
  }

  static setAddres(String address) async {
    await sharedPreferences.setString(constants.address, address);
  }

  static String getAddres() {
    if (sharedPreferences != null) {
      return sharedPreferences.getString(constants.address);
    } else {
      Database.initDatabase();
    }
  }

  static logout() async {
    sharedPreferences.clear();

    Database.initDatabase();
    Database.setAddres("Pune");
  }

  static setEmail(String email) async {
    await sharedPreferences.setString(constants.email, email);
  }

  static String getEmail() {
    return sharedPreferences.getString(constants.email);
  }

  static String isKycCompleted() {
    return sharedPreferences.getString(constants.kycCompleted);
  }

  static setKycStatus() async {
    await sharedPreferences.setString(constants.kycCompleted, constants.kycCompleted);
  }
}
