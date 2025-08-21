import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i_smile_kids_app/features/appointment/presentation/views/doctors_view.dart';
import 'package:i_smile_kids_app/features/brushing_timer/presentation/views/brushing_time_view.dart';
import 'package:i_smile_kids_app/features/reward_points/presentation/views/reward_points_view.dart';
import 'package:i_smile_kids_app/features/visit_timer/presentation/views/visit_timer_view.dart';

class CategoriesModel {
  final IconData icon;
  final String title;
  final Widget? view;

  CategoriesModel({required this.icon, required this.title, this.view});
}

List<CategoriesModel> categorieList = [
  CategoriesModel(
    icon: FontAwesomeIcons.calendar,
    title: 'Book Appointment',
    view: DoctorsVeiw(),
  ),
  CategoriesModel(
    icon: FontAwesomeIcons.alarmClock,
    title: 'Burshing Time',
    view: BrushingTimerView(),
  ),
  CategoriesModel(
    icon: FontAwesomeIcons.trophy,
    title: 'Loyalty Points',
    view: LoyaltyPointsView(),
  ),
  CategoriesModel(
    icon: FontAwesomeIcons.checkDouble,
    title: 'Next Visit',
    view: NextVisitTimeView(),
  ),
];
