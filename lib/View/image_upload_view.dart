import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knucl_face_analyzer_2025/View/face_analyze_result_view.dart';
import '../ViewModel/image_upload_viewmodel.dart';

import '../common/toast_notification.dart';

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
  Uint8List? _image = null;
  final ImageUploadViewModel _imageUploadViewModel = ImageUploadViewModel();


  void selectImage() {
    ref
        .read(imageSelectProvider.future)
        .then((value) {
          _image = value;
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
    errorNotification(context, _mainWarningText, _warnignExpalin);
    selectImage();
  }

  Future<String> uploadImage(Uint8List encodedImage) async {
    String _imageUrl = await _imageUploadViewModel.saveImage(encodedImage);
    return _imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            _underButtons(context, _requestButtonText, _image, uploadImage),
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

Widget _underButtons(BuildContext context, String _requestButtonText, Uint8List? _imageData, Future<String> Function(Uint8List) uploadImage) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
      _goToNextPageButton(context, _requestButtonText, _imageData, uploadImage),
      _backButton(context),
    ],
  );
}

Widget _goToNextPageButton(BuildContext context, String _requestButtonText, Uint8List? _image, Future<String> Function(Uint8List) uploadImage) {
  return ElevatedButton(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(
        Colors.black,
      ),
      foregroundColor: WidgetStateProperty.all<Color>(
        Colors.white,
      ),
    ),
    onPressed: () async {
      if (_image == null) {
        errorNotification(context, "사진 선택 실패", "사진을 선택해주세요.");
        return;
      }
      try{
        String _imageUrl = await uploadImage(_image!);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => FaceAnalyzeResultView(imageUrl: _imageUrl,)));
      } catch (error, stackTrace) {
        errorNotification(context, "사진 업로드 실패",error.toString().split(":")[5].split(",")[0]);
        log("Error: $error, StackTrace: $stackTrace");
      }
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