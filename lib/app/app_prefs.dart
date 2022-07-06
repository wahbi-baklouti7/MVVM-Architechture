import 'package:mvvm_architechture/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';


const prefKeyLanguage="prefKeyLanguage";
const prefKeyOnboardingViewed="prefKeyOnboardingViewed";
const prefKeyIsLoggedIn="prefKeyIsLoggedIn";
class AppPreferences{


final SharedPreferences _sharedPreferences;
AppPreferences(this._sharedPreferences);


// return language from setting , default language is English
Future<String> getAppLanguage()async{
  String? language=  _sharedPreferences.getString(prefKeyLanguage);
  if(language != null && language.isNotEmpty){
    return language;
  }else{
    return LanguagesType.english.getValue();
  }
}


// on boarding
Future<void> setOnboardingViewed()async{
  _sharedPreferences.setBool(prefKeyOnboardingViewed, true);
  
}

Future<bool> isOnboardingViewed()async{
return  _sharedPreferences.getBool(prefKeyOnboardingViewed)??false;
  
}

// is logged in 
Future<void> setIsLoggedIn()async{
  _sharedPreferences.setBool(prefKeyIsLoggedIn, true);
  
}

Future<bool> isLoggedIn()async{
return  _sharedPreferences.getBool(prefKeyIsLoggedIn)??false;
  
}
}