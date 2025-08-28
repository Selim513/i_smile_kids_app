import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:i_smile_kids_app/core/helper/asset_helper.dart';
import 'package:i_smile_kids_app/core/services/firebase_brushing_time_manger.dart';
import 'package:i_smile_kids_app/core/services/firebase_point_manger.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_elevated_button.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_appbar.dart';
import 'package:i_smile_kids_app/core/widgets/custom_snack_bar.dart';

class BrushingTimerView extends StatefulWidget {
  const BrushingTimerView({super.key});

  @override
  State<BrushingTimerView> createState() => _BrushingTimerViewState();
}

class _BrushingTimerViewState extends State<BrushingTimerView> {
  int _seconds = 10;
  Timer? _timer;
  bool isRunning = false;
  bool hasFinished = false;

  final int _initialSeconds = 10;

  @override
  void initState() {
    super.initState();
    _checkAccess();
  }

  // التحقق من إمكانية الوصول عند دخول الصفحة
  Future<void> _checkAccess() async {
    final canAccess = await BrushingScheduleManager.canAccessBrushingTimer();
    if (!canAccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop(); // العودة للصفحة السابقة
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Access denied. Please check the allowed times.'),
            backgroundColor: Colors.red,
          ),
        );
      });
    }
  }

  void pauseTimer() {
    _timer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void resetTimer() {
    _timer?.cancel();
    setState(() {
      _seconds = _initialSeconds;
      isRunning = false;
      hasFinished = false;
    });
  }

  void startOrResumeTimer() {
    if (isRunning || hasFinished) return;

    setState(() {
      isRunning = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
      } else {
        timer.cancel();
        setState(() {
          isRunning = false;
          hasFinished = true;
        });

        // إضافة النقاط وتسجيل الجلسة
        await addPoints(100);
        await BrushingScheduleManager.recordBrushingSession();
        if (mounted) {
          CustomSnackBar.brushingTimerEnd(context);
        }

        // العودة للصفحة الرئيسية بعد 3 ثواني
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get timerText {
    int minutes = _seconds ~/ 60;
    int seconds = _seconds % 60;
    return "$minutes:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomPrimaryAppbar(title: 'Brushing Timer'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 20.h,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 150.r,
                  width: 150.r,
                  child: CircularProgressIndicator(
                    strokeWidth: 30.w,
                    color: ColorManager.primary,
                    backgroundColor: ColorManager.border,
                    value: _seconds / _initialSeconds,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      timerText,
                      style: FontManger.primaryFontColorRoboto25.copyWith(
                        color: ColorManager.primary,
                      ),
                    ),
                    SizedBox(
                      height: 70,
                      child: AssetHelper.imageAsset(name: 'brushing'),
                    ),
                  ],
                ),
              ],
            ),
            Gap(10.h),
            CustomEleveatedButton(
              onPress: hasFinished ? () {} : startOrResumeTimer,
              child: Text(
                hasFinished
                    ? 'Completed!'
                    : (isRunning ? 'Running...' : 'Start'),
                style: FontManger.whiteBoldFont20,
              ),
            ),
            Row(
              spacing: 10.w,
              children: [
                Expanded(
                  child: CustomEleveatedButton(
                    borderColor: ColorManager.primary,
                    bgColor: Colors.white,
                    onPress: isRunning ? pauseTimer : () {},
                    child: Text(
                      'Pause',
                      style: FontManger.meduimFontBlack14.copyWith(
                        color: ColorManager.primary,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: CustomEleveatedButton(
                    borderColor: ColorManager.primary,
                    bgColor: Colors.white,
                    onPress: hasFinished ? () {} : resetTimer,
                    child: Text(
                      'Reset',
                      style: FontManger.meduimFontBlack14.copyWith(
                        color: ColorManager.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          
          ],
        ),
      ),
    );
  }
}
