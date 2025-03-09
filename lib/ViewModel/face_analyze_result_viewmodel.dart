import 'dart:async';
import 'package:flutter/material.dart';
import 'package:knucl_face_analyzer_2025/DataLayer/Service/AnalyzeService.dart';

/**
 * @Structure :
 * 관상 분석은 서버에서 진행됩니다. 그리고 그 결과는 임시적으로만 저장하면 되고, 따로 저장할 필요는 없습니다.
 * 따라서 해당 클래스는 레포지토리를 거치지 않고, Service를 직접 호출합니다.
 */

///

class FaceAnalyzeResultViewModel extends ChangeNotifier {
  final AnalyzeService _analyzeService = AnalyzeService();
  final StreamController<String> _streamController = StreamController<String>.broadcast();

  Stream<String> get resultStream => _streamController.stream;

  FaceAnalyzeResultViewModel();

  void loadFaceData(String imageUrl) async {
    try {
      String result = await _analyzeService.getSSEStream(imageUrl);
      for (int i = 0; i < result.length; i++) {
        _streamController.add(result[i]);
        await Future.delayed(Duration(milliseconds: 100));
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
}