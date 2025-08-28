import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:i_smile_kids_app/core/helper/firebase_helper.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_appbar.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_container.dart';
import 'package:i_smile_kids_app/features/reward_points/presentation/views/widgets/kids_voucher_card.dart';

class LoyaltyPointsView extends StatefulWidget {
  const LoyaltyPointsView({super.key});

  @override
  State<LoyaltyPointsView> createState() => _LoyaltyPointsViewState();
}

class _LoyaltyPointsViewState extends State<LoyaltyPointsView> {
  int _points = 0;

  @override
  void initState() {
    super.initState();
    _loadPoints();
  }

  Future<void> _loadPoints() async {
    final user = FirebaseHelper.user;
    if (user == null) return;

    final doc = await FirebaseHelper.firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .get();

    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      setState(() {
        _points = data['points'] ?? 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomPrimaryAppbar(title: 'Loyalty Points'),
      body: Padding(
        padding: EdgeInsetsGeometry.all(20.r),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomPrimaryContainer(
                borderColor: Colors.transparent,
                bgColor: ColorManager.primary.withValues(alpha: 0.3),
                widgets: Column(
                  children: [
                    Text(
                      'Your Available Reward ',
                      style: FontManger.primaryFontColorRoboto25.copyWith(
                        color: ColorManager.success,
                      ),
                    ),
                    // Text('🎉', style: TextStyle(fontSize: 30.sp)),
                    const Icon(FontAwesomeIcons.gift, color: ColorManager.warning),
                    Gap(10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: FontManger.blackBoldFont18.copyWith(
                              color: Colors.blue,
                              fontSize: 22.sp,
                            ),
                            children: [
                              TextSpan(text: '$_points '),
                              TextSpan(
                                text: 'Points',
                                style: FontManger.meduimFontBlack14,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Gap(10.h),
              const KidsVoucherCard(
                placeName: "Kidzania Mall",
                offer: "🎢 Free Entry Ticket",
                expiryDate: "30 Aug 2025",
                image: "assets/images/kidTest.png",
              ),
              Gap(10.h),
              const KidsVoucherCard(
                placeName: "mcdonald's",
                offer: "Free Happy Meal",
                expiryDate: "30 Aug 2025",
                image: "assets/images/kidTest2.png",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:gap/gap.dart';
// import 'package:i_smile_kids_app/core/services/firebase_point_manger.dart';
// import 'package:i_smile_kids_app/core/utils/color_manger.dart';
// import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
// import 'package:i_smile_kids_app/core/widgets/custom_primary_appbar.dart';
// import 'package:i_smile_kids_app/core/widgets/custom_primary_container.dart';
// // استيراد Firebase Points Manager

// class LoyaltyPointsView extends StatefulWidget {
//   const LoyaltyPointsView({super.key});

//   @override
//   State<LoyaltyPointsView> createState() => _LoyaltyPointsViewState();
// }

// class _LoyaltyPointsViewState extends State<LoyaltyPointsView> {
//   int _currentPoints = 0;
//   bool _isLoading = true;
//   List<Map<String, dynamic>> _pointsHistory = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadPoints();
//     _loadPointsHistory();
//   }

//   // تحميل النقاط الحالية من Firebase
//   Future<void> _loadPoints() async {
//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final points = await FirebasePointsManager.getCurrentPoints();
//       setState(() {
//         _currentPoints = points;
//       });
//     } catch (e) {
//       print('Error loading points: $e');
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Error loading points'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   // تحميل تاريخ النقاط
//   Future<void> _loadPointsHistory() async {
//     try {
//       final history = await FirebasePointsManager.getPointsHistory();
//       setState(() {
//         _pointsHistory = history;
//       });
//     } catch (e) {
//       print('Error loading points history: $e');
//     }
//   }

//   // تحديث النقاط عند العودة للصفحة
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _loadPoints();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomPrimaryAppbar(title: 'Loyalty Points'),
//       body: RefreshIndicator(
//         onRefresh: () async {
//           await _loadPoints();
//           await _loadPointsHistory();
//         },
//         child: _isLoading
//             ? Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CircularProgressIndicator(color: ColorManager.primary),
//                     Gap(20.h),
//                     Text(
//                       'Loading your points...',
//                       style: FontManger.meduimFontBlack14,
//                     ),
//                   ],
//                 ),
//               )
//             : Padding(
//                 padding: EdgeInsets.all(20.r),
//                 child: SingleChildScrollView(
//                   physics: const AlwaysScrollableScrollPhysics(),
//                   child: Column(
//                     children: [
//                       // عرض النقاط الحالية
//                       CustomPrimaryContainer(
//                         borderColor: Colors.transparent,
//                         bgColor: ColorManager.primary.withOpacity(0.3),
//                         widgets: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Your Available Reward',
//                               style: FontManger.primaryFontColorRoboto25
//                                   .copyWith(color: ColorManager.success),
//                             ),
//                             Icon(
//                               FontAwesomeIcons.gift,
//                               color: ColorManager.warning,
//                               size: 30.sp,
//                             ),
//                             Gap(10.h),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 RichText(
//                                   text: TextSpan(
//                                     style: FontManger.blackBoldFont18.copyWith(
//                                       color: Colors.blue,
//                                       fontSize: 22.sp,
//                                     ),
//                                     children: [
//                                       TextSpan(text: '$_currentPoints '),
//                                       TextSpan(
//                                         text: 'Points',
//                                         style: FontManger.meduimFontBlack14,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       Gap(20.h),

//                       // عرض الجوائز المتاحة حسب النقاط
//                       if (_currentPoints >= 500) ...[
//                         _buildRewardCard(
//                           title: "McDonald's Reward",
//                           subtitle: "🍔 Free Happy Meal",
//                           cost: 500,
//                           available: _currentPoints >= 500,
//                         ),
//                         Gap(10.h),
//                       ],

//                       if (_currentPoints >= 1000) ...[
//                         _buildRewardCard(
//                           title: "Kidzania Experience",
//                           subtitle: "🎢 Free Entry Ticket",
//                           cost: 1000,
//                           available: _currentPoints >= 1000,
//                         ),
//                         Gap(10.h),
//                       ],

//                       if (_currentPoints >= 1500) ...[
//                         _buildRewardCard(
//                           title: "Toy Store Voucher",
//                           subtitle: "🧸 50 AED Voucher",
//                           cost: 1500,
//                           available: _currentPoints >= 1500,
//                         ),
//                         Gap(10.h),
//                       ],

//                       // عرض الجوائز القادمة إذا لم تكن النقاط كافية
//                       if (_currentPoints < 500) ...[
//                         CustomPrimaryContainer(
//                           bgColor: ColorManager.primary.withOpacity(0.1),
//                           widgets: Column(
//                             children: [
//                               Icon(
//                                 FontAwesomeIcons.star,
//                                 color: ColorManager.primary,
//                                 size: 30.sp,
//                               ),
//                               Gap(10.h),
//                               Text(
//                                 'Keep Brushing! 🦷',
//                                 style: FontManger.blackBoldFont18.copyWith(
//                                   color: ColorManager.primary,
//                                 ),
//                               ),
//                               Gap(5.h),
//                               Text(
//                                 'You need ${500 - _currentPoints} more points to unlock your first reward!',
//                                 style: FontManger.meduimFontBlack14,
//                                 textAlign: TextAlign.center,
//                               ),
//                               Gap(10.h),
//                               Text(
//                                 'Each brushing session = 100 points',
//                                 style: FontManger.meduimFontBlack14.copyWith(
//                                   color: ColorManager.primary,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ],
//                           ),
//                         ),
//                         Gap(20.h),
//                       ],

//                       // عرض تاريخ النقاط إذا وجد
//                       if (_pointsHistory.isNotEmpty) ...[
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             'Recent Activity',
//                             style: FontManger.blackBoldFont18.copyWith(
//                               color: ColorManager.primary,
//                             ),
//                           ),
//                         ),
//                         Gap(10.h),
//                         ...(_pointsHistory
//                             .take(5)
//                             .map((activity) => _buildActivityTile(activity))),
//                         Gap(20.h),
//                       ],
//                     ],
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }

//   // ويدجت لعرض بطاقة الجائزة
//   Widget _buildRewardCard({
//     required String title,
//     required String subtitle,
//     required int cost,
//     required bool available,
//   }) {
//     return CustomPrimaryContainer(
//       bgColor: available
//           ? ColorManager.success.withOpacity(0.1)
//           : ColorManager.border.withOpacity(0.1),
//       borderColor: available ? ColorManager.success : ColorManager.border,
//       widgets: Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: FontManger.blackBoldFont18.copyWith(
//                     color: available ? ColorManager.success : Colors.grey,
//                   ),
//                 ),
//                 Gap(5.h),
//                 Text(subtitle, style: FontManger.meduimFontBlack14),
//                 Gap(5.h),
//                 Text(
//                   '$cost Points',
//                   style: FontManger.meduimFontBlack14.copyWith(
//                     color: ColorManager.primary,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           if (available)
//             Icon(
//               FontAwesomeIcons.check,
//               color: ColorManager.success,
//               size: 20.sp,
//             )
//           else
//             Icon(FontAwesomeIcons.lock, color: Colors.grey, size: 20.sp),
//         ],
//       ),
//     );
//   }

//   // ويدجت لعرض نشاط النقاط
//   Widget _buildActivityTile(Map<String, dynamic> activity) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 10.h),
//       padding: EdgeInsets.all(15.r),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10.r),
//         border: Border.all(color: ColorManager.border),
//       ),
//       child: Row(
//         children: [
//           Icon(FontAwesomeIcons.plus, color: ColorManager.success, size: 16.sp),
//           Gap(10.w),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   activity['reason'] ?? 'Points earned',
//                   style: FontManger.meduimFontBlack14,
//                 ),
//                 Gap(2.h),
//                 Text(
//                   '+${activity['points']} points',
//                   style: FontManger.meduimFontBlack14.copyWith(
//                     color: ColorManager.success,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
