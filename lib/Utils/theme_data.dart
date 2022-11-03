import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app_colors.dart';

class ThemeServices {
  final lightTheme = ThemeData.light().copyWith(
    textTheme: ThemeData.light().textTheme.apply(
      fontFamily: 'kufi_font',
    ),
    primaryTextTheme: ThemeData.light().textTheme.apply(
      fontFamily: 'kufi_font',
    ),
    scaffoldBackgroundColor: AppColors.WHITE_COLOR,
    appBarTheme: const AppBarTheme(
      color: AppColors.APPBAR_COLOR,
      foregroundColor: AppColors.BLACK_COLOR,
    ),
    listTileTheme: const ListTileThemeData(
      tileColor: AppColors.APPBAR_COLOR,
    ),
    snackBarTheme: const SnackBarThemeData(
      contentTextStyle: TextStyle(
        color: AppColors.WHITE_COLOR
      ),
        backgroundColor: AppColors.BLACK_COLOR
    ),
    cardTheme:  const CardTheme(
      color: AppColors.APPBAR_COLOR,
    ),
    drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.WHITE_COLOR
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.WHITE_COLOR,
    ),
    dividerColor: Colors.black12,
  );

  final darkTheme = ThemeData.dark().copyWith(
    textTheme: ThemeData.dark().textTheme.apply(
      fontFamily: 'kufi_font',
    ),
    primaryTextTheme: ThemeData.dark().textTheme.apply(
      fontFamily: 'kufi_font',
    ),
    scaffoldBackgroundColor: AppColors.BLACK_COLOR,
    appBarTheme: const AppBarTheme(
      color: AppColors.BLACK_COLOR,
      // backgroundColor: AppColors.WHITE_COLOR,
      foregroundColor: AppColors.WHITE_COLOR,
    ),
    snackBarTheme: const SnackBarThemeData(
        contentTextStyle: TextStyle(
            color: AppColors.BLACK_COLOR
        ),
      backgroundColor: AppColors.WHITE_COLOR
    ),
    listTileTheme: const ListTileThemeData(
      tileColor: AppColors.Tile_DARK_COLOR,
    ),
    cardTheme: const CardTheme(
      color: AppColors.Tile_DARK_COLOR,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppColors.BLACK_COLOR
    ),
    bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.BLACK_COLOR,
    ),
    dividerColor: Colors.white54,
  );

  final _getStorage = GetStorage();


  void saveThemeData(bool isDarkMode) {
    _getStorage.write("isDarkTheme", isDarkMode);
    _getStorage.write("ThemeTitle", isDarkMode?"Dark":"Light");
  }

  bool isSavedDarkMode() {
    return _getStorage.read("isDarkTheme") ?? false;
  }

  ThemeMode getThemeMode() {
    return isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  void changeTheme() {
    Get.changeThemeMode(isSavedDarkMode() ? ThemeMode.light : ThemeMode.dark);
    saveThemeData(!isSavedDarkMode());
  }
}
