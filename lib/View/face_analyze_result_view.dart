import 'package:flutter/material.dart';
import '../ViewModel/face_analyze_result_viewmodel.dart';
import 'home_view.dart';

class FaceAnalyzeResultView extends StatefulWidget {
  final String imageUrl;

  const FaceAnalyzeResultView({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _FaceAnalyzeResultViewState createState() => _FaceAnalyzeResultViewState();
}

class _FaceAnalyzeResultViewState extends State<FaceAnalyzeResultView> {
  final String _pageTitle = "분석 결과";
  late final FaceAnalyzeResultViewModel _viewModel;
  StringBuffer _result = StringBuffer();

  final String _tempResult = "얼굴의 각 요소를 살펴보면, 우선 눈은 사람의 감정을 표현하는 중요한 부분입니다. 이 경우, 선글라스를 착용하고 있어 눈의 감정이나 감성을 직접적으로 파악하기는 어렵지만, 일반적으로 선글라스는 자신감이나 쿨함을 나타낼 수 있습니다.\n\n코는 얼굴의 중심에 위치하며, 균형감과 조화를 이루는 역할을 합니다. 이 경우 코의 모양이나 크기는 잘 보이지 않지만, 일반적으로 코의 형태는 그 사람의 성격이나 개성을 반영하기도 합니다.\m\m입은 감정 표현의 중요한 수단으로, 미소나 찡그림을 통해 기분을 전달합니다. 이 사람의 입은 다소 무표정해 보이며, 이는 신중함이나 진지함을 나타낼 수 있습니다.\m\m머리 모양은 개성을 나타내는 중요한 요소로, 이 경우 짧고 깔끔한 스타일이 특징입니다. 이는 일반적으로 깔끔함, 정돈된 이미지를 주며, 활동적이고 생기 있는 인상을 줄 수 있습니다.\m\m총괄적으로 보면, 이 사람은 자신감이 넘치고, 신중하며, 깔끔한 이미지를 가진 인물로 해석될 수 있습니다. 각 요소의 조화가 그 사람의 전반적인 성격과 인상을 형성하는 데 기여하고 있습니다.";

  @override
  void initState() {
    super.initState();
    _viewModel = FaceAnalyzeResultViewModel();
    _viewModel.loadFaceData(widget.imageUrl);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
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
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(12),
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
                        child: Center(
                          child: Image.network(
                            widget.imageUrl,
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: MediaQuery.of(context).size.height * 0.25,
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.025),
                          child: Container(
                            width : MediaQuery.of(context).size.width * 0.85,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: StreamBuilder<String>(
                          stream: _viewModel.resultStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasData) {
                              _result.write(snapshot.data);
                              return SingleChildScrollView(child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.025),
                                child: Text(_result.toString() ?? "", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03)),
                              ));
                            } else {
                              return SingleChildScrollView(child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.025),
                                child: Text(_tempResult, style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03)),
                              ));
                            }
                          },
                        ),
                      ),
                    ]
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