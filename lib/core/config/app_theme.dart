import 'package:flutter/material.dart';

class AppTheme {
static const primaryColorLight = Color(0xFFBA68C8);
static const primaryColorDark = Color(0xFFBA68C8);
static const lightBackground = Color(0xFFEDE3FF);
static const darkBackground = Color(0xFFFFF8E1);

//text
static const lightTextColor = Colors.white;
static const darkTextColor = Colors.white;

//selected/unselected tabs
static const selectedColorLight = Color(0xFF8E24AA);
static const unselectedColorLight = Colors.grey;
static const selectedColorDark = Color(0xFFBA68C8);
static const unselectedColorDark = Colors.grey;

//light theme
static ThemeData lightTheme(Locale locale) {
return ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: lightBackground,
  fontFamily: 'PlayfairDisplay',
  colorScheme: ColorScheme.fromSeed(
   seedColor: primaryColorLight,
    brightness: Brightness.light,
  ).copyWith(
   background: lightBackground,
    primary: primaryColorLight,
    secondary: unselectedColorLight,
  ),
  textTheme: const TextTheme(
   bodyLarge: TextStyle(color: lightTextColor),
    bodyMedium: TextStyle(color: lightTextColor),
  ),
  iconTheme: const IconThemeData(color: darkTextColor),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
   selectedItemColor: lightTextColor,
    unselectedItemColor: unselectedColorLight,
    backgroundColor: lightBackground,
  ),
  tabBarTheme: const TabBarThemeData(
   labelColor:lightTextColor ,
    unselectedLabelColor:lightTextColor ,
    indicatorColor: lightTextColor,
  ),
  appBarTheme: const AppBarTheme(
   backgroundColor: lightBackground,
    elevation: 0,
    iconTheme: IconThemeData(color:lightTextColor ),
    titleTextStyle: TextStyle(
     color: lightTextColor,
      fontFamily: 'PlayfairDisplay',
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  ),
  cardColor: Colors.white,
);
  }

//dark theme
static ThemeData darkTheme(Locale locale) {
return ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: darkBackground,
  fontFamily: 'PlayfairDisplay',
  colorScheme: ColorScheme.fromSeed(
   seedColor: primaryColorDark,
    brightness: Brightness.dark,
  ).copyWith(
   background: darkBackground,
    primary: selectedColorDark,
    secondary: unselectedColorDark,
  ),
  textTheme: const TextTheme(
   bodyLarge: TextStyle(color: darkTextColor),
    bodyMedium: TextStyle(color: darkTextColor),
  ),
  iconTheme: const IconThemeData(color: unselectedColorDark),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
   selectedItemColor: selectedColorDark,
    unselectedItemColor: unselectedColorDark,
    backgroundColor: darkBackground,
  ),
  tabBarTheme: const TabBarThemeData(
   labelColor: darkTextColor,
    unselectedLabelColor: darkTextColor,
    indicatorColor: darkTextColor,
  ),
  appBarTheme: const AppBarTheme(
  backgroundColor: Color(0xFF1E1E1E),
   elevation: 0,
    iconTheme: IconThemeData(color: darkBackground),
    titleTextStyle: TextStyle(
     color: darkTextColor,
      fontFamily: 'PlayfairDisplay',
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  ),
  cardColor: const Color(0xFFFFF8E1),
);
  }
}