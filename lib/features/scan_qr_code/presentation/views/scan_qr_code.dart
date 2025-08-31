import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrCodeView extends StatefulWidget {
  const ScanQrCodeView({super.key});

  @override
  State<ScanQrCodeView> createState() => _ScanQrCodeViewState();
}

class _ScanQrCodeViewState extends State<ScanQrCodeView> {
  String? result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Code Scanner')),
      body: Column(
        children: <Widget>[
          // الجزء الذي يعرض معاينة الكاميرا
          Expanded(
            flex: 4,
            child: MobileScanner(
              controller: MobileScannerController(),
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  setState(() {
                    result = barcode.rawValue ?? "....";
                  });
                }
              },
            ),
          ),
          // الجزء الذي يعرض نتيجة المسح
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: (result != null)
                    ? Text(
                        'Result: $result',
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      )
                    : const Text(
                        'To confirm your visit, please scan the QR code with the doctor.',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
