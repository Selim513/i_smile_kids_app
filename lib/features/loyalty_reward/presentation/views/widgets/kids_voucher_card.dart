import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_container.dart';

class KidsVoucherCard extends StatelessWidget {
  final String placeName;
  final String offer;
  final String expiryDate;
  final String image;

  const KidsVoucherCard({
    super.key,
    required this.placeName,
    required this.offer,
    required this.expiryDate,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPrimaryContainer(
      padding: EdgeInsets.all(10.r),
      widgets: CouponCard(
        height: 200.h,
        borderRadius: 20,
        backgroundColor: Colors.white,
        firstChild: Container(
          decoration: BoxDecoration(
            color: Colors.orange.shade400,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              bottomLeft: Radius.circular(20.r),
            ),
            image: DecorationImage(
              image: AssetImage(image), // صورة المطعم أو الملاهي
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withValues(alpha: 0.3),
                BlendMode.darken,
              ),
            ),
          ),
          child: Center(
            child: Text(
              offer, // العرض (زي Free Burger)
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        secondChild: Container(
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                placeName,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                "Valid until: $expiryDate",
                style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () {
                    // هنا تحط منطق الـ Redeem
                  },
                  child: Text(
                    "Redeem Now",
                    style: TextStyle(fontSize: 14.sp, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
