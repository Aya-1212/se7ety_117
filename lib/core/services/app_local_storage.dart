import 'package:shared_preferences/shared_preferences.dart';

class AppLocalStorage {
//static late  SharedPreferences user ;
  // init() async{
  //  user = await SharedPreferences.getInstance();
  // }
 static cacheUserData (key, dynamic value) async{
  final user = await SharedPreferences.getInstance();
  if(value is int){
    user.setInt(key,value);
  } else if(value is double){
     user.setDouble(key, value);
  }else if(value is bool){
      user.setBool(key, value);
  }else{
       user.setString(key, value);
  }
 }
 static Future<dynamic> getUserData (key) async{
  final user = await SharedPreferences.getInstance();
  return user.get(key);
 }
}