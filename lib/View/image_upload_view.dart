import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knucl_face_analyzer_2025/View/face_analyze_result_view.dart';
import '../ViewModel/image_upload_viewmodel.dart';
import 'package:toastification/toastification.dart';

class ImageUploadView extends ConsumerStatefulWidget {
  const ImageUploadView({super.key});

  @override
  ConsumerState<ImageUploadView> createState() => _ImageUploadViewState();
}

class _ImageUploadViewState extends ConsumerState<ImageUploadView> {
  final String _imageRequestText = "노션 페이스 이미지를 선택해주시오!";
  final String _requestButtonText = "분석 요청하기";
  final String _mainWarningText = "이미지를 선택해주세요.";
  final String _warnignExpalin = "빈 이미지는 허용되지 않습니다!";

  AsyncValue<Uint8List>? _imageData = AsyncValue.loading();

  void selectImage() {
    ref
        .read(imageSelectProvider.future)
        .then((value) {
          setState(() {
            _imageData = AsyncValue.data(value);
          });
        })
        .catchError((error, stackTrace) {
          errorAlertAndReSelect(error, stackTrace);
          setState(() {
            _imageData = AsyncValue.error(error, stackTrace);
          });
        });
  }

  void errorAlertAndReSelect(error, stacktrace) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 3),
      title: Text(_mainWarningText, style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.015)),
      // you can also use RichText widget for title and description parameters
      description: RichText(
        text: TextSpan(text: _warnignExpalin),
      ),
      alignment: Alignment.topRight,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      icon: const Icon(Icons.error_outline),
      showIcon: true,
      // show or hide the icon
      primaryColor: Colors.red,
      backgroundColor: Colors.black,
      foregroundColor: Colors.red,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      showProgressBar: true,
      closeButton: ToastCloseButton(
        showType: CloseButtonShowType.onHover,
      ),
    );
    selectImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFcdc5b1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //사진을 선택하라는 텍스트
            _imageRequestBody(context, _imageRequestText),
            SizedBox(height: 20),
            //사진 선택 상자 -> 사진 선택하면 이미지가 나옴
            if (_imageData != null)
              Container(
                width: MediaQuery.of(context).size.height * 0.55,
                height: MediaQuery.of(context).size.height * 0.55,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _imageData!.when(
                  data: (data) => Image.memory(data, fit: BoxFit.cover),
                  loading:
                      () => GestureDetector(
                        onTap: selectImage,
                        // Correctly calling selectImage here
                        child: Icon(
                          Icons.image,
                          size: MediaQuery.of(context).size.width * 0.2,
                        ),
                      ),
                  error:
                      (error, stackTrace) => Icon(
                        Icons.error,
                        size: MediaQuery.of(context).size.width * 0.2,
                      ),
                ),
              ),
            //분석하기 버튼
            _underButtons(context, _requestButtonText),
          ],
        ),
      ),
    );
  }
}

Widget _imageRequestBody(BuildContext context, String _imageRequestText) {
  return Text(
    _imageRequestText,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: MediaQuery.of(context).size.width * 0.05,
    ),
  );
}

Widget _underButtons(BuildContext context, String _requestButtonText) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
      _goToNextPageButton(context, _requestButtonText),
      _backButton(context),
    ],
  );
}

Widget _goToNextPageButton(BuildContext context, String _requestButtonText) {
  return ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        Colors.black,
      ),
      foregroundColor: MaterialStateProperty.all<Color>(
        Colors.white,
      ),
    ),
    onPressed: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => FaceAnalyzeResultView()));
    },
    child: Text(_requestButtonText, style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.015)),
  );
}

Widget _backButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.pop(context);
    },
    child: Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.0175),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        width: MediaQuery.of(context).size.width * 0.08,
        height: MediaQuery.of(context).size.width * 0.04,
        child: Text("이전", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.015)),
      ),
    ),
  );
}