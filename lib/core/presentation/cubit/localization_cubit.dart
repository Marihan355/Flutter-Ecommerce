import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../data/datasources/storage_local_data_source.dart';

class LocalizationCubit extends Cubit<Locale> {
final StorageLocalDataSource storage;

static const Locale defaultLocale = Locale('en');  //default is english
LocalizationCubit(this.storage) : super(defaultLocale);

Future<void> loadLocale() async {   //load language
 try {
  final code = await storage.getSavedLocaleCode();  //get
   if (code != null && code.isNotEmpty) {      //if user chooses one
   emit(Locale(code));                        //use it
   } else {
  emit(defaultLocale);                    //otherwise, give me the default
   }
  } catch (_) {
   emit(defaultLocale);
  }
}

Future<void> toggleLanguage() async {
  final currentCode = state.languageCode; //get current
  final newCode = currentCode == 'en' ? 'ar' : 'en'; //get ne
  await storage.saveLocaleCode(newCode); 
  emit(Locale(newCode));  //store new
  }
}
