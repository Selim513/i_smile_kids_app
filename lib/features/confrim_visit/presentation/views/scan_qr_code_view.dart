import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_smile_kids_app/core/widgets/custom_snack_bar.dart';
import 'package:i_smile_kids_app/features/confrim_visit/data/data_source/handle_qr_scan_remote_data_source.dart';
import 'package:i_smile_kids_app/features/confrim_visit/data/repo/hanlde_qr_scan_repo_impl.dart';
import 'package:i_smile_kids_app/features/confrim_visit/presentation/manger/scan_qr_cubit/scan_qr_cubit.dart';
import 'package:i_smile_kids_app/features/confrim_visit/presentation/manger/scan_qr_cubit/scan_qr_state.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrCodeView extends StatefulWidget {
  const ScanQrCodeView({super.key});

  @override
  State<ScanQrCodeView> createState() => _ScanQrCodeViewState();
}

class _ScanQrCodeViewState extends State<ScanQrCodeView>
    with AutomaticKeepAliveClientMixin {
  final MobileScannerController controller = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  String? lastQr;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) =>
          QrScanCubit(HanldeQrScanRepoImpl(HandleQrScanRemoteDataSourceImpl())),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('QR Code Scanner'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: BlocConsumer<QrScanCubit, QrScanState>(
          listener: (context, state) async {
            if (state is QrScanInSuccess || state is QrScanFailure) {
              controller.stop();

              if (state is QrScanInSuccess) {
                CustomSnackBar.successSnackBar(state.succMessage, context);
              } else if (state is QrScanFailure) {
                CustomSnackBar.errorSnackBar(state.errMessage, context);
              }

              await Future.delayed(const Duration(seconds: 3));

              if (context.mounted) {
                Navigator.of(context).pop();
              }
            }
          },
          builder: (context, state) {
            final isProcessing = state is QrScanInLoading;

            return Column(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: MobileScanner(
                    key: GlobalKey(),
                    controller: controller,
                    onDetect: (capture) {
                      if (isProcessing) return;

                      final barcode = capture.barcodes.firstOrNull;
                      final qrData = barcode?.rawValue;

                      if (qrData == null || qrData.isEmpty) return;

                      if (qrData == lastQr) return;
                      lastQr = qrData;

                      context.read<QrScanCubit>().handleQrScan(qrData: qrData);
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: isProcessing
                          ? const CircularProgressIndicator()
                          : const Text(
                              'Please scan the doctor\'s QR code to confirm your visit.',
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
