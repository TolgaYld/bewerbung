import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerPage extends HookConsumerWidget {
  const QrScannerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useMemoized(() => MobileScannerController());
    final isHandled = useState<bool>(false);

    useEffect(() => controller.dispose, []);

    return Scaffold(
      appBar: AppBar(title: const AutoSizeText('QR Scanner')),
      body: MobileScanner(
        controller: controller,
        onDetect: (BarcodeCapture capture) async {
          if (isHandled.value) return;

          final value = capture.barcodes.firstOrNull?.rawValue;
          if (value != null) {
            isHandled.value = true;
            try {
              await controller.stop();
            } on PlatformException catch (e) {
              debugPrint('Error stopping scanner: $e');
            }
            if (context.mounted && context.canPop()) {
              context.pop(value);
            }
          }
        },
      ),
    );
  }
}
