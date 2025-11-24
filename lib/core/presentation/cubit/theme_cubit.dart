import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/storage_local_data_source.dart'; //uses shared preference

class ThemeCubit extends Cubit<ThemeMode> {
final StorageLocalDataSource storage;
ThemeCubit(this.storage) : super(ThemeMode.system); //my cubit recieves storage (injected). and before any of that the cubit gets, just use the system theme

//load theme
void loadTheme() {
 final isDark = storage.getThemeIsDark(); 
  emit(isDark ?                  //check it it's dark, if not , then light
 ThemeMode.dark : ThemeMode.light);
}

//toggle theme
void toggleTheme() {
final newMode = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;  //state is the current theme
 storage.saveThemeIsDark(newMode == ThemeMode.dark);
  emit(newMode);
  }
}
