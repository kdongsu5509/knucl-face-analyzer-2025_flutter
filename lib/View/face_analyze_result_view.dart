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
                              return Center(child: CircularProgressIndicator(
                                color: Colors.black54,
                              ));
                            } else if (snapshot.hasData) {
                              _result.write(snapshot.data);
                              return SingleChildScrollView(child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.025),
                                child: Text(_result.toString() ?? "", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03)),
                              ));
                            } else {
                              return SingleChildScrollView(child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.025),
                                child: Text(_result.toString(), style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03)),
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
            GestureDetector(
    onTap: () {
    Future.delayed(Duration.zero, () {
    _viewModel.showQrCodePopup(context, _viewModel.resultUuid!, widget.imageUrl,);
    });
    },
              child: Icon(
                Icons.qr_code,
                size: MediaQuery.of(context).size.width * 0.03,
              ),
            ),
          ],
        ),
      ],
    );
  }
}