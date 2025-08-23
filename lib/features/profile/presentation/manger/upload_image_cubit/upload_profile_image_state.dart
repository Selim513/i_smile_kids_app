abstract class UploadPickedProfileImageState {}

class PickProfileImageInitial extends UploadPickedProfileImageState {}

class PickImageLoading extends UploadPickedProfileImageState {}

class PickImageSuccess extends UploadPickedProfileImageState {
  final String imagePath;
  final String? succMessage;

  PickImageSuccess({this.succMessage, required this.imagePath});
}

class PickImageFailure extends UploadPickedProfileImageState {
  final String errMessage;

  PickImageFailure({required this.errMessage});
}
