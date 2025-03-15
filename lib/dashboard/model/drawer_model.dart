import 'package:flutter/cupertino.dart';

class DrawerModel {
  final String? title;
  final Widget? icon;
  final String? route;

  DrawerModel({
    this.title,
    this.icon,
    this.route,
  });

  factory DrawerModel.fromJson(Map<String, dynamic> json) {
    return DrawerModel(
      title: json['title'] as String?,
      icon: json['icon'] as Widget?,
      route: json['route'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'icon': icon,
      'route': route,
    };
  }
}