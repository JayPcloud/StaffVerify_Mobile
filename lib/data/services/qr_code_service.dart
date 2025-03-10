import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:qr_flutter/qr_flutter.dart';

class VQRCodeGenerator {
  final String qrData;

  VQRCodeGenerator({
    required this.qrData,
  });

  Widget toImageWidget({required GlobalKey key}) {
    final qrImage = RepaintBoundary(
      key: key,
      child: QrImageView(
        data: qrData,
        version: QrVersions.auto,
        size: 200,
      ),
    );
    return qrImage;
  }

  Future<Uint8List?> toUInt8List() async{
    final qrPaint = QrPainter(
      data: qrData,
      version: QrVersions.auto,
      gapless: false,
    );
    final qrImage = await qrPaint.toImageData(200);
    return qrImage?.buffer.asUint8List();
  }

}
