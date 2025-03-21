import 'dart:async';
import 'package:flutter/material.dart';
import 'package:knucl_face_analyzer_2025/DataLayer/Service/AnalyzeService.dart';

import '../DataLayer/dto/analyze_result_dto.dart';
import '../View/qr_code_view.dart';

/**
 * @Structure :
 * 관상 분석은 서버에서 진행됩니다. 그리고 그 결과는 임시적으로만 저장하면 되고, 따로 저장할 필요는 없습니다.
 * 따라서 해당 클래스는 레포지토리를 거치지 않고, Service를 직접 호출합니다.
 */

///

class FaceAnalyzeResultViewModel extends ChangeNotifier {
  final AnalyzeService _analyzeService = AnalyzeService();
  final StreamController<String> _streamController = StreamController<String>.broadcast();
  String? _resultUuid;

  Stream<String> get resultStream => _streamController.stream;
  String? get resultUuid => _resultUuid;

  FaceAnalyzeResultViewModel();

  void loadFaceData(String imageUrl) async {
    try {
      AnalyzeResultDTO resultDto = await _analyzeService.getSSEStream(imageUrl);
      String result = resultDto.result;
      _resultUuid = resultDto.uuid;
      for (int i = 0; i < result.length; i++) {
        _streamController.add(result[i]);
        await Future.delayed(Duration(milliseconds: 50));
      }
      _streamController.close();
    } catch (e) {
      _streamController.addError(e);
    }
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  void showQrCodePopup(BuildContext context, String resultUuid, String imageUrl,) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('QR 코드'),
          content: SizedBox(
            width: 320,
            height: 320,
            child: QrCodeView(resultUuid: resultUuid, imageUrl: imageUrl),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('닫기'),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        );
      },
    );
  }

}