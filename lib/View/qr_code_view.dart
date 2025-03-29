import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:developer';
class QrCodeView extends StatelessWidget {
  final String resultUuid;
  final String imageUrl;

  QrCodeView({
    Key? key,
    required this.resultUuid,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('${dotenv.env['baseUrl']}/knucl/$resultUuid?data=$imageUrl');
    return QrImageView(
      backgroundColor: Colors.white,
      data: '${dotenv.env['baseUrl']}/knucl/$resultUuid?data=$imageUrl',
      version: QrVersions.auto,
      size: 320,
      gapless: false,
    );
  }
}
