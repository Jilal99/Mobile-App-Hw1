import 'package:flutter/material.dart';
import 'package:socialmedia/log_in.dart';
import 'package:socialmedia/menu.dart';
import 'package:socialmedia/register.dart';

class AppRoutes {
  AppRoutes._();

  static const String authLogin = '/auth-Login';
  static const String authRegister = '/auth-register';
  static const String menu = '/menu';
  static Map<String, WidgetBuilder> define() {
    return {
      authLogin: (context) => Login(),
      authRegister: (context) => Register(),
      menu: (context) => Menu(),
    };
  }
}
