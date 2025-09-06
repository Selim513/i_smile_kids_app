import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_appbar.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_container.dart';
import 'package:i_smile_kids_app/features/video_tips/data/models/video_tips_model.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';

class VideosTipsView extends StatelessWidget {
  const VideosTipsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomPrimaryAppbar(title: 'Videos Tips', leading: SizedBox()),

      body: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: 10.w,
              vertical: 10.h,
            ),
            child: CustomPrimaryContainer(
              widgets: Row(
                spacing: 10.w,
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: VideoTipsPreview(videoId: videos[index].id),
                          withNavBar: false,
                        );
                      },
                      child: Stack(
                        alignment: AlignmentGeometry.center,
                        children: [
                          Image.network(
                            videos[index].thumbnail,
                            fit: BoxFit.cover,
                            height: 100.h,
                          ),
                          Icon(
                            Icons.play_arrow,
                            size: 50.sp,
                            color: ColorManager.lightGreyColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      videos[index].title,
                      style: FontManger.blackBoldFont18,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class VideoTipsPreview extends StatelessWidget {
  const VideoTipsPreview({super.key, required this.videoId});
  final String videoId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: VimeoVideoPlayer(videoId: videoId),
    );
  }
}
