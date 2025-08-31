import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_elevated_button.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_appbar.dart';
import 'package:i_smile_kids_app/features/confrim_visit/presentation/views/scan_qr_code_view.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class ConfirmYourVisitView extends StatelessWidget {
  const ConfirmYourVisitView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomPrimaryAppbar(title: 'Confrim your visit'),
      body: Padding(
        padding: EdgeInsetsGeometry.all(20.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: LottieBuilder.asset('assets/json/scan_qr_code.json'),
            ),
            CustomEleveatedButton(
              child: Text('Scan now', style: FontManger.whiteBoldFont20),
              onPress: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: ScanQrCodeView(),
                  withNavBar: false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
