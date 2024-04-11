import 'package:hive/hive.dart';

class AppLocalStorage {
  static late Box userBox ;
  static init(){
   userBox= Hive.box('user');

  }
  static cacheUserData(key,value){
  userBox.put(key, value);
   }

   static getUserData (key){
    return userBox.get(key);
   }  
}