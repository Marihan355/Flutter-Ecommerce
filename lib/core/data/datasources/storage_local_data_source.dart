import 'package:shared_preferences/shared_preferences.dart'; //shared preference(key:value)
import 'package:flutter/material.dart';

class StorageLocalDataSource {
final SharedPreferences prefs;
StorageLocalDataSource._(this.prefs);                                           //private constructor

static late final StorageLocalDataSource instance;//singleton instance: only one object of this class will exist and the whole app will use it

//initialization
static Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();
  instance = StorageLocalDataSource._(prefs);
}

static SharedPreferences get prefsSync => instance.prefs;
static const activeLocaleKey = 'ACTIVE_LOCALE';
static const onboardingKey = 'ONBOARDING_DONE';
static const themeModeKey = 'THEME_MODE';

//save language
Future<void> saveLocaleCode(String code) async {
    await prefsSync.setString(activeLocaleKey, code);
 }

//get language
Future<String?> getSavedLocaleCode() async {
    return prefsSync.getString(activeLocaleKey); //get the value of the key
 }

//set language
Future<void> setActiveLocale(Locale locale) async =>
prefsSync.setString(activeLocaleKey, locale.languageCode); //ex: locale=("en", "US"), en is languagecode, set key and value

//if onboarding page is done
bool get onboardingCompleted => prefsSync.getBool(onboardingKey) ?? false; 
Future<void> setOnboardingCompleted() async =>
prefsSync.setBool(onboardingKey, true);

//get themedark?
bool getThemeIsDark() {
  return prefsSync.getBool(themeModeKey) ?? false;
 }
//set Theme
Future<void> saveThemeIsDark(bool isDark) async {
  await prefsSync.setBool(themeModeKey, isDark);
 }
}
