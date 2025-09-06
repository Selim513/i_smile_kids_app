// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';
// import 'package:i_smile_kids_app/core/helper/asset_helper.dart';
// import 'package:i_smile_kids_app/core/services/firebase_brushing_time_manger.dart';
// import 'package:i_smile_kids_app/core/services/firebase_point_manger.dart';
// import 'package:i_smile_kids_app/core/utils/color_manger.dart';
// import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
// import 'package:i_smile_kids_app/core/widgets/custom_elevated_button.dart';
// import 'package:i_smile_kids_app/core/widgets/custom_primary_appbar.dart';
// import 'package:i_smile_kids_app/core/widgets/custom_snack_bar.dart';

// class BrushingTimeView extends StatefulWidget {
//   const BrushingTimeView({super.key});

//   @override
//   State<BrushingTimeView> createState() => _BrushingTimeViewState();
// }

// class _BrushingTimeViewState extends State<BrushingTimeView> {
//   int _seconds = 10;
//   Timer? _timer;
//   bool isRunning = false;
//   bool hasFinished = false;

//   final int _initialSeconds = 10;

//   @override
//   void initState() {
//     super.initState();
//     _checkAccess();
//   }

//   // التحقق من إمكانية الوصول عند دخول الصفحة
//   Future<void> _checkAccess() async {
//     final canAccess = await BrushingScheduleManager.canAccessBrushingTimer();
//     if (!canAccess) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         Navigator.of(context).pop(); // العودة للصفحة السابقة
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Access denied. Please check the allowed times.'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       });
//     }
//   }

//   void pauseTimer() {
//     _timer?.cancel();
//     setState(() {
//       isRunning = false;
//     });
//   }

//   void resetTimer() {
//     _timer?.cancel();
//     setState(() {
//       _seconds = _initialSeconds;
//       isRunning = false;
//       hasFinished = false;
//     });
//   }

//   void startOrResumeTimer() {
//     if (isRunning || hasFinished) return;

//     setState(() {
//       isRunning = true;
//     });

//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
//       if (_seconds > 0) {
//         setState(() {
//           _seconds--;
//         });
//       } else {
//         timer.cancel();
//         setState(() {
//           isRunning = false;
//           hasFinished = true;
//         });

//         // إضافة النقاط وتسجيل الجلسة
//         await addPoints(100);
//         await BrushingScheduleManager.recordBrushingSession();
//         if (mounted) {
//           CustomSnackBar.brushingTimerEnd(context);
//         }

//         // العودة للصفحة الرئيسية بعد 3 ثواني
//         Future.delayed(const Duration(seconds: 3), () {
//           if (mounted) {
//             Navigator.of(context).popUntil((route) => route.isFirst);
//           }
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   String get timerText {
//     int minutes = _seconds ~/ 60;
//     int seconds = _seconds % 60;
//     return "$minutes:${seconds.toString().padLeft(2, '0')}";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomPrimaryAppbar(title: 'Brushing Timer'),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           spacing: 20.h,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 SizedBox(
//                   height: 250.r,
//                   width: 250.r,
//                   child: CircularProgressIndicator(
//                     strokeWidth: 40.w,
//                     color: ColorManager.primary,
//                     backgroundColor: ColorManager.border,
//                     value: _seconds / _initialSeconds,
//                   ),
//                 ),
//                 Column(
//                   spacing: 10.h,
//                   children: [
//                     Text(
//                       timerText,
//                       style: FontManger.primaryFontColorRoboto25.copyWith(
//                         color: ColorManager.primary,
//                         fontSize: 30.sp,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 80,
//                       child: AssetHelper.gifAsset(name: '5'),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Gap(10.h),
//             CustomEleveatedButton(
//               onPress: () {},
//               // hasFinished ? () {} : startOrResumeTimer,
//               child: Text(
//                 hasFinished
//                     ? 'Completed!'
//                     : (isRunning ? 'Running...' : 'Start'),
//                 style: FontManger.whiteBoldFont20,
//               ),
//             ),
//             Row(
//               spacing: 10.w,
//               children: [
//                 Expanded(
//                   child: CustomEleveatedButton(
//                     borderColor: ColorManager.primary,
//                     bgColor: Colors.white,
//                     onPress: isRunning ? pauseTimer : () {},
//                     child: Text(
//                       'Pause',
//                       style: FontManger.meduimFontBlack14.copyWith(
//                         color: ColorManager.primary,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: CustomEleveatedButton(
//                     borderColor: ColorManager.primary,
//                     bgColor: Colors.white,
//                     onPress: hasFinished ? () {} : resetTimer,
//                     child: Text(
//                       'Reset',
//                       style: FontManger.meduimFontBlack14.copyWith(
//                         color: ColorManager.primary,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
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

class BrushingTimeView extends StatefulWidget {
  const BrushingTimeView({super.key});

  @override
  State<BrushingTimeView> createState() => _BrushingTimeViewState();
}

class _BrushingTimeViewState extends State<BrushingTimeView> {
  int _seconds = 120;
  Timer? _timer;
  bool isRunning = false;
  bool hasFinished = false;

  final int _initialSeconds = 120;

  // متغيرات للتحكم في ملفات GIF
  int currentGifIndex = 1;
  int gifRepeatCount = 0;
  Timer? _gifTimer;
  final int gifDuration =
      10; // مدة عرض كل GIF بالثواني (يمكنك تعديلها حسب الحاجة)

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

  void _startGifAnimation() {
    currentGifIndex = 1;
    gifRepeatCount = 0;
    _nextGif();
  }

  void _nextGif() {
    if (!isRunning) return;

    _gifTimer?.cancel();
    _gifTimer = Timer(Duration(seconds: gifDuration), () {
      if (!isRunning) return;

      setState(() {
        gifRepeatCount++;

        // إذا كنا في آخر GIF (رقم 5)، نبقى عليه
        if (currentGifIndex == 5) {
          // نبقى على GIF رقم 5 حتى انتهاء التايمر
          _nextGif(); // نعيد استدعاء الدالة للاستمرار
        } else if (gifRepeatCount >= 2) {
          // إذا تم تكرار GIF الحالي مرتين، ننتقل للتالي
          currentGifIndex++;
          gifRepeatCount = 0;
          _nextGif();
        } else {
          // نكرر نفس GIF مرة أخرى
          _nextGif();
        }
      });
    });
  }

  void pauseTimer() {
    _timer?.cancel();
    _gifTimer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void resetTimer() {
    _timer?.cancel();
    _gifTimer?.cancel();
    setState(() {
      _seconds = _initialSeconds;
      isRunning = false;
      hasFinished = false;
      currentGifIndex = 1;
      gifRepeatCount = 0;
    });
  }

  void startOrResumeTimer() {
    if (isRunning || hasFinished) return;

    setState(() {
      isRunning = true;
    });

    // بدء تشغيل ملفات GIF
    _startGifAnimation();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
      } else {
        timer.cancel();
        _gifTimer?.cancel();
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
    _gifTimer?.cancel();
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
                  height: 250.r,
                  width: 250.r,
                  child: CircularProgressIndicator(
                    strokeWidth: 40.w,
                    color: ColorManager.primary,
                    backgroundColor: ColorManager.border,
                    value: _seconds / _initialSeconds,
                  ),
                ),
                Column(
                  spacing: 10.h,
                  children: [
                    Text(
                      timerText,
                      style: FontManger.primaryFontColorRoboto25.copyWith(
                        color: ColorManager.primary,
                        fontSize: 30.sp,
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      child: AssetHelper.gifAsset(
                        name: currentGifIndex.toString(),
                        key: ValueKey(
                          currentGifIndex,
                        ), // للتأكد من إعادة تحميل GIF
                      ),
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
