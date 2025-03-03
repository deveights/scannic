import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
import 'package:scannic/data/dummy_data.dart';
import 'package:scannic/screens/item_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String scannedText = "Scan a Barcode";

  MobileScannerController controller = MobileScannerController(
    formats: [BarcodeFormat.all],
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  @override
  void initState() {
    super.initState();
    controller.start();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scannic')),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            MobileScanner(
              fit: BoxFit.cover,
              controller: controller,
              onDetect: (BarcodeCapture barcode) async {
                final String scannedId =
                    barcode.barcodes.map((data) => data.rawValue).join();

                setState(() {
                  scannedText = scannedId;
                });

                final scannedProduct =
                    dummyData
                            .where((product) => product.id == scannedId)
                            .isNotEmpty
                        ? dummyData.firstWhere(
                          (product) => product.id == scannedId,
                        )
                        : null;

                if (scannedProduct != null) {
                  await Future.delayed(Duration(milliseconds: 500))
                      .then((value) {
                        if (context.mounted) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) => ItemDetailsScreen(
                                    product: scannedProduct,
                                  ),
                            ),
                          );
                        }
                      })
                      .then((value) => controller.start());
                }
                controller.stop();

                if (scannedProduct == null) return;
              },
            ),
            QRScannerOverlay(
              overlayColor: Colors.black.withAlpha((255 * 0.3).toInt()),
            ),
            Positioned(
              bottom: 50,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(16),
                child: Text(
                  textAlign: TextAlign.center,
                  scannedText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
