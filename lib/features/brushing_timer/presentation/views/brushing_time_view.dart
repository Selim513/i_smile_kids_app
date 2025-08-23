import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:i_smile_kids_app/core/helper/asset_helper.dart';
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
  int _seconds = 10; // دقيقتين = 10 ثانية
  Timer? _timer;
  final bool isRunning = false;

  final int _initialSeconds = 10;
  void pauseTimer() {
    _timer?.cancel();
  }

  void resetTimer() {
    _timer?.cancel();
    setState(() {
      _seconds = _initialSeconds;
    });
  }

  void startOrResumeTimer() {
    if (isRunning) return;
    isRunning == true;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
      } else {
        timer.cancel();
        isRunning == false;
        CustomSnackBar.brushingTimerEnd(context);
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
      appBar: CustomPrimaryAppbar(title: 'Brushing Timer'),

      body: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20.h,
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
                    value: _seconds / 10,
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
              onPress: () {
                startOrResumeTimer();
              },
              child: Text('Start', style: FontManger.whiteBoldFont18),
            ),
            Row(
              spacing: 10.w,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: CustomEleveatedButton(
                    borderColor: ColorManager.primary,
                    bgColor: Colors.white,
                    onPress: () {
                      pauseTimer();
                    },
                    child: Text(
                      'Pauase',
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
                    onPress: () {
                      resetTimer();
                    },
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
            // CustomPrimaryContainer(
            //   bgColor: ColorManager.success,
            //   widgets: Column(
            //     children: [
            //       Text('Well Done Ahmed !', style: FontManger.whiteBoldFont18),
            //       Text(
            //         'You earned 1+ point 🎉',
            //         style: FontManger.meduimFontBlack14.copyWith(
            //           color: ColorManager.secondary,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
