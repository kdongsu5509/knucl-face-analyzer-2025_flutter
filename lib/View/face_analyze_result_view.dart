import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knucl_face_analyzer_2025/View/home_view.dart';
import 'package:knucl_face_analyzer_2025/ViewModel/face_analyze_result_viewmodel.dart';

class FaceAnalyzeResultView extends ConsumerStatefulWidget {
  final String imageUrl;

  const FaceAnalyzeResultView({super.key, required this.imageUrl});

  @override
  ConsumerState<FaceAnalyzeResultView> createState() =>
      _FaceAnalyzeResultViewState();
}

class _FaceAnalyzeResultViewState extends ConsumerState<FaceAnalyzeResultView> {

  FaceAnalyzeResultViewModel _viewModel = FaceAnalyzeResultViewModel();

  late String _imageAddress;
  String _pageTitle = "분석 결과";

  @override
  void initState() {
    super.initState();

    //이미지 ID를 통해 이미지를 가져옴
    _imageAddress = widget.imageUrl.toString();

    //분석 결과는 Flux 패턴 사용하여 가져옴

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFcdc5b1),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.05,
          MediaQuery.of(context).size.width * 0.02,
          MediaQuery.of(context).size.width * 0.05,
          MediaQuery.of(context).size.width * 0.01,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _faceAnalyzerTitle(context, _pageTitle),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Center(
                        child: Image.network(
                          _imageAddress,
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                      ),
                      Text(
                        "사용자가 업로드한 이미지(S3 주소로)\n이미지 분석 결과가 나오는 곳",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.05,
                        ),
                      ),
                    ]
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

Widget _faceAnalyzerTitle(BuildContext context, String title) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      // _faceAnalyzerTitle(context),
      Text(
        title,
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.05,
        ),
      ),
      Row(
        children: [
          GestureDetector(
            onTap:
                () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeView()),
            ),
            child: Icon(
              Icons.home,
              size: MediaQuery.of(context).size.width * 0.035,
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.01),
          Icon(
            Icons.share,
            size: MediaQuery.of(context).size.width * 0.03,
          ),
        ],
      ),
    ],
  );
}