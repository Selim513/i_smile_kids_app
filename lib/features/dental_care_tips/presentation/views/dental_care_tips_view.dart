import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_appbar.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_container.dart';
import 'package:readmore/readmore.dart';

class DentalCareTipsView extends StatelessWidget {
  const DentalCareTipsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomPrimaryAppbar(title: 'Dental Care Tips'),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 20.r,
                    vertical: 5.h,
                  ),
                  child: CustomPrimaryContainer(
                    widgets: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: 10.w,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              style: IconButton.styleFrom(
                                foregroundColor: ColorManager.primary,
                                backgroundColor: ColorManager.primary
                                    .withValues(alpha: 0.2),
                              ),
                              onPressed: () {},
                              icon: const Icon(FontAwesomeIcons.tooth),
                            ),
                            Expanded(
                              child: Column(
                                spacing: 5,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Brush Twice a Day',
                                    style: FontManger.blackBoldFont18,
                                  ),
                                  GestureDetector(
                                    child: ReadMoreText(
                                      'Brush your teeth two times a day for two minutes, once in the morning and once before bed to keep them healthy and strong.',
                                      style: FontManger.subTitleTextBold14,
                                      trimMode: TrimMode.Line,
                                      trimLines: 3,
                                      colorClickableText: ColorManager.primary,
                                      trimCollapsedText: 'Show more',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
