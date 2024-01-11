import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isDarkModeProvider = StateProvider<bool>((ref) => true);

class AppTheme {
  static const defaultPrimaryColor = Color.fromARGB(255, 60, 16, 66);
  static final Color defaultAccentColor = Colors.purple[800] ?? Colors.purple;

  static ColorScheme lightColorScheme = ColorScheme.fromSeed(
      seedColor: defaultPrimaryColor, brightness: Brightness.light);

  static ThemeData lightTheme() => ThemeData(
      fontFamily: 'Quicksand',
      useMaterial3: true,
      colorScheme: lightColorScheme,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: defaultAccentColor,
      ),
      cardTheme: CardTheme(elevation: 8.0),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0)),
        shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
      )),
      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.grey.withOpacity(0.1)));

  static ThemeData darkTheme() => ThemeData(
        fontFamily: 'Quicksand',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: defaultPrimaryColor, brightness: Brightness.dark),
        switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.all<Color>(Colors.grey),
          thumbColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
        inputDecorationTheme: InputDecorationTheme(
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: defaultPrimaryColor)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide.none),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.1)),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0)),
          shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0))),
        )),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 16.0)),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0))))),
        // backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        // foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        // overlayColor:
        //     MaterialStateProperty.all<Color>(Colors.black26))),
      );
}
