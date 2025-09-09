import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_smile_kids_app/features/confrim_visit/data/repo/hanlde_qr_scan_repo_impl.dart';
import 'package:i_smile_kids_app/features/confrim_visit/presentation/manger/scan_qr_cubit/scan_qr_state.dart';

class QrScanCubit extends Cubit<QrScanState> {
  final HanldeQrScanRepoImpl repo;
  QrScanCubit(this.repo) : super(QrScanInitialState());

  Future<void> handleQrScan({required String qrData}) async {
    try {
      emit(QrScanInLoading());
      await repo.handleQrScan(qrData: qrData);
      emit(
        QrScanInSuccess(
          succMessage: '🎉 50 points have been added for your doctor\'s visit!',
        ),
      );
    } catch (e) {
      emit(QrScanFailure(errMessage: e.toString()));
    }
  }
}
