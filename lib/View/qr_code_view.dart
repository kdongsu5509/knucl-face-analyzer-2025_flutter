import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeView extends StatelessWidget {
  final String resultUuid;

  QrCodeView({
    Key? key,
    required this.resultUuid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QrImageView(
      data: 'http://${dotenv.env['baseUrl']}/face/result/$resultUuid',
      version: QrVersions.auto,
      size: 320,
      gapless: false,
    );
  }
}
