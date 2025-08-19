// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';

// class CreateAccountPickProfileImage extends StatelessWidget {
//   const CreateAccountPickProfileImage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return CircleAvatar(
//       radius: 50.r,
//       backgroundColor: const Color.fromRGBO(229, 231, 235, 1),
//       child: Column(
//         spacing: 5.h,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.add, color: Colors.grey),
//           Text(
//             'Add photo',
//             style: FontManger.regularFontBlack12.copyWith(color: Colors.grey),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/features/auth/presentation/manger/auth_cubit.dart';
import 'package:i_smile_kids_app/features/auth/presentation/manger/auth_state.dart';
import 'package:image_picker/image_picker.dart';

class CreateAccountPickProfileImage extends StatelessWidget {
  const CreateAccountPickProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthCubitState>(
      builder: (context, state) {
        final cubit = context.read<AuthCubit>();
        return InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (_) {
                return SafeArea(
                  child: Wrap(
                    children: [
                      ListTile(
                        leading: Icon(Icons.photo_library),
                        title: Text("Gallery"),
                        onTap: () {
                          cubit.pickImage(ImageSource.gallery);
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.camera_alt),
                        title: Text("Camera"),
                        onTap: () {
                          cubit.pickImage(ImageSource.camera);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: CircleAvatar(
            radius: 50.r,
            backgroundColor: const Color.fromRGBO(229, 231, 235, 1),
            child: cubit.pickedImage == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: Colors.grey),
                      Text(
                        'Add photo',
                        style: FontManger.regularFontBlack12.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                : ClipOval(
                    child: Image.file(
                      cubit.pickedImage!,
                      width: 100.w,
                      height: 100.h,
                      fit: BoxFit.cover, // بيظبط الصورة جوه الدايرة
                    ),
                  ),
          ),
        );
      },
    );
  }
}
