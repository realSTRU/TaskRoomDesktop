import 'package:desk/dto/menu_model.dart';
import 'package:flutter/material.dart';

class SideMenuData{
  final menu = const <MenuModel>[
    MenuModel(icon:Icons.home, title: 'Dashboard'),
    MenuModel(icon:Icons.logout, title: 'SignOut')
  ];
}