import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knucl_face_analyzer_2025/View/image_upload_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    String rawTitle1 = "노션 페이스로";
    String rawTitle2 = "나의 관상 알아보기";

    String title1 = rawTitle1.split("").join("\n");
    String title2 = rawTitle2.split("").join("\n");

    return Scaffold(
      body: Container(
        width: double.infinity, // 전체 화면 너비
        height: double.infinity, // 전체 화면 높이
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("asset/mybackground.jpeg"),
            fit: BoxFit.cover, // 배경을 꽉 채우기
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Image.asset("asset/logo.jpeg", width: 300),
            ),
            Center(
              child: Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 860)),
                  Padding(
                    padding: EdgeInsets.only(top: 950),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          Colors.black,
                        ),
                        foregroundColor: WidgetStateProperty.all<Color>(
                          Colors.white,
                        ),
                      ),
                      onPressed:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImageUploadView(),
                            ),
                          ),
                      child: Text("시작하기", style: TextStyle(fontSize: 37)),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 500)),
                  Text(
                    title1,
                    style: TextStyle(
                      fontSize: 80,
                      color: Colors.black,
                      letterSpacing: 10,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(padding: EdgeInsets.only(left: 30)),
                  Text(
                    title2,
                    style: TextStyle(
                      fontSize: 60,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
