import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoriesModel {
  final IconData icon;
  final String title;

  CategoriesModel({required this.icon, required this.title});
}

List<CategoriesModel> categorieList = [
  CategoriesModel(icon: FontAwesomeIcons.calendar, title: 'Book Appointment'),
  CategoriesModel(icon: FontAwesomeIcons.alarmClock, title: 'Burshing Timer'),
  CategoriesModel(icon: FontAwesomeIcons.trophy, title: 'Reward points'),
  CategoriesModel(icon: FontAwesomeIcons.timeline, title: 'Visit Timer'),
];
