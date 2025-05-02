import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerPage extends StatelessWidget {
  const QrScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AutoSizeText('QR Scanner')),
      body: MobileScanner(
        onDetect: (BarcodeCapture capture) {
          final barcode = capture.barcodes.first;
          final value = barcode.rawValue;

          if (value != null) {
            if (context.canPop()) {
              context.pop(value);
            }
          }
        },
      ),
    );
  }
}
