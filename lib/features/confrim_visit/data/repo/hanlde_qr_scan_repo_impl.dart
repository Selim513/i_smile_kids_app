import 'package:i_smile_kids_app/features/confrim_visit/data/data_source/handle_qr_scan_remote_data_source.dart';
import 'package:i_smile_kids_app/features/confrim_visit/data/repo/handle_qr_scan_repo.dart';

class HanldeQrScanRepoImpl extends HandleQrScanRepo {
  final HandleQrScanRemoteDataSourceImpl repo;

  HanldeQrScanRepoImpl(this.repo);
  @override
  Future<void> handleQrScan({required String qrData}) {
    return repo.handleQrScan(qrData: qrData);
  }
}
