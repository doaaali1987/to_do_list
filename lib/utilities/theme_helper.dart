import 'package:flutter/material.dart';

class ThemeHelper {
  static Color primaryColorLight = const Color(0xff5d9cec);
  static Color accentColorLight = const Color(0xffDFECDB);
  static Color primaryDarkColor = const Color(0xff5D9CEC);
  static Color accentColorDark = const Color(0xff060E1E);
  static Color greyColor=const Color(0xffa4aca4);
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: accentColorLight,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      //backgroundColor: ThemeHelper.navBottomBarLight,
      selectedItemColor:primaryColorLight,
      unselectedItemColor:greyColor,
      showUnselectedLabels: false,
      showSelectedLabels: false,
    ),
    primaryColor: primaryColorLight,
    accentColor: accentColorLight,
    appBarTheme: AppBarTheme(
      elevation: 0,
      titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          fontFamily: "El Messiri"),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
backgroundColor: primaryColorLight,
    ),
    backgroundColor: primaryColorLight,
    textTheme: TextTheme(
      titleMedium: TextStyle(fontWeight: FontWeight.bold,color: primaryColorLight,fontSize: 18),
      titleSmall: TextStyle(fontWeight: FontWeight.normal,color: Colors.black,fontSize: 12),
      displayMedium: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18),
      displaySmall: TextStyle(fontWeight: FontWeight.normal,color: Colors.black,fontSize: 16),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
    //backgroundColor: ThemeHelper.navBottomBarDark,
    //selectedItemColor: ThemeHelper.navBottomBarDark,
  ),
    primaryColor: primaryDarkColor,
    accentColor: accentColorDark,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      titleTextStyle: TextStyle(
          fontSize: 30,
          //color: ThemeHelper.titleAppBarDark,
          fontWeight: FontWeight.bold,
          fontFamily: "El Messiri"),
    ),
   // backgroundColor: ThemeHelper.navBottomBarDark,
    textTheme: TextTheme(
        titleMedium: TextStyle(fontWeight: FontWeight.bold,color: primaryDarkColor,fontSize: 18),
        titleSmall: TextStyle(fontWeight: FontWeight.normal,color: Colors.black,fontSize: 12)
    ),
  );
}
