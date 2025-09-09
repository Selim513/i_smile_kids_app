abstract class QrScanState {}

class QrScanInitialState extends QrScanState {}

class QrScanInLoading extends QrScanState {}

class QrScanInSuccess extends QrScanState {
  final String succMessage;

  QrScanInSuccess({required this.succMessage});
}

class QrScanFailure extends QrScanState {
  final String errMessage;

  QrScanFailure({required this.errMessage});
}
