import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/shared/styles/colors.dart';

ThemeData darkMode=ThemeData(
  brightness: Brightness.dark,
  floatingActionButtonTheme:const FloatingActionButtonThemeData(foregroundColor: Colors.white,backgroundColor: Colors.deepOrange) ,
  scaffoldBackgroundColor: HexColor('#393939'),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: HexColor('#393939'),
        statusBarIconBrightness: Brightness.light
    ),
    titleTextStyle: const TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold,),
    surfaceTintColor: HexColor('#393939'),
    elevation: 0,
    backgroundColor: HexColor('#393939'),
    actionsIconTheme: const IconThemeData(color: Colors.white),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    unselectedItemColor: Colors.white,
    backgroundColor: HexColor('#393939'),
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
  ),
) ;

ThemeData lightMode=ThemeData(
  brightness: Brightness.light,
  floatingActionButtonTheme:const FloatingActionButtonThemeData(foregroundColor: Colors.white,backgroundColor: primaryColor) ,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark
    ),
    titleTextStyle: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold,),
    surfaceTintColor: Colors.white,
    elevation: 0,
    backgroundColor: Colors.white,
    actionsIconTheme: IconThemeData(color: Colors.black),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      unselectedItemColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primaryColor,
      backgroundColor: Colors.white
  ),

);