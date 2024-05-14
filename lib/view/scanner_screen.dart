import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scanner_app/model/company_model.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool shouldShowQr = false;
  CompanyModel user = CompanyModel(
      name: 'Nikhil Panvar', companyName: 'XYZ solutions', isPinned: false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 1 / 6,
                    backgroundImage: const NetworkImage(
                        'https://i.pinimg.com/564x/76/f8/0c/76f80c03ec446cb4499c565d749b7b2b.jpg'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      user.name,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          shouldShowQr = !shouldShowQr;
                        });
                      },
                      child: const Text('SHOW MY QR'))
                ],
              ),
            ),
          ),
          Expanded(
              flex: 4,
              child: shouldShowQr
                  ? Container(
                      color: Colors.white,
                      width: double.infinity,
                      child: Center(
                        child: QrImageView(
                          data: user.toString(),
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                      ),
                    )
                  : QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                      overlay: QrScannerOverlayShape(
                        borderColor: Colors.red,
                        borderRadius: 10,
                        borderLength: 30,
                        borderWidth: 10,
                        //    cutOutSize: scanArea
                      ),
                    )),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text('Event Mode'),
                      Switch(
                        value: true,
                        onChanged: (value) {},
                      )
                    ],
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        focusColor: Colors.deepPurpleAccent,
                        hintText: 'Enter Your Event Name'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text('Share Your Info'),
                      Switch(
                        value: true,
                        onChanged: (value) {},
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      result = scanData;
      CompanyModel company = companyModelFromJson(result!.code!);
      print(result!.code);
      controller.pauseCamera();
      Provider.of<NetworkProvider>(context, listen: false)
          .addToNetwork(company);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 2),
          content: Text('Connection added to your Networking page')));
      Future.delayed(
        const Duration(seconds: 3),
        () => controller.resumeCamera(),
      );

      return;
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
