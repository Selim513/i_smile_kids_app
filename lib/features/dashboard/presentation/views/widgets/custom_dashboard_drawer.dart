import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:i_smile_kids_app/core/helper/firebase_helper.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/features/dashboard/presentation/views/qr_code_view.dart';
import 'package:i_smile_kids_app/features/dashboard/presentation/views/widgets/custom_dashboard_drawer_header.dart';
import 'package:i_smile_kids_app/features/splash/presentation/splash_view.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Header
          CustomDashboardDrawerHeader(),

          Gap(20.h),

          // Menu Items
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  // Complete Visit
                  _buildDrawerItem(
                    icon: Icons.check_circle_outline,
                    title: 'Complete Visit',
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate to complete visit page
                    },
                  ),

                  Gap(10.h),

                  // Total Patients
                  _buildDrawerItem(
                    icon: Icons.people_outline,
                    title: 'Total Patients',
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate to total patients page
                    },
                  ),

                  Gap(10.h),

                  // Scan QR
                  _buildDrawerItem(
                    icon: Icons.qr_code_scanner_outlined,
                    title: 'Scan QR',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QrCodeView()),
                      );
                      // Navigate to QR scanner page
                    },
                  ),

                  Spacer(),

                  // Logout
                  _buildDrawerItem(
                    icon: Icons.logout,
                    title: 'Logout',
                    onTap: () {
                      // FirebaseHelper.userAuth.signOut();
                      FirebaseHelper.userAuth.signOut();
                      if (context.mounted) {
                        Navigator.of(
                          context,
                          rootNavigator: true,
                        ).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const SplashView(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      }
                    },
                    isLogout: true,
                  ),

                  Gap(20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isLogout
            ? ColorManager.error.withValues(alpha: 0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isLogout ? ColorManager.error : ColorManager.primary,
          size: 24.sp,
        ),
        title: Text(
          title,
          style: FontManger.blackBoldFont18.copyWith(
            fontSize: 16.sp,
            color: isLogout ? ColorManager.error : Colors.black,
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      ),
    );
  }
}
