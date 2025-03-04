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
            getCLLogo(context),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.12,
                  ),
                  startButton(context),
                  applicationTitle(context, title1, title2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget getCLLogo(BuildContext context) {
  return Padding(
    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.01, MediaQuery.of(context).size.width * 0.01, 0, 0),
    child: Image.asset("asset/logo.jpeg", width: MediaQuery.of(context).size.width * 0.15),
  );
}

Widget startButton(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.8),
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
      child: Text("시작하기", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.02)),
    ),
  );
}

Widget applicationTitle(BuildContext context, String title1, String title2) {
  return Padding(
    padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.05, MediaQuery.of(context).size.width * 0.05, MediaQuery.of(context).size.height * 0.05),
    child: Row(
      children: [
        Text(
          title1,
          style: titleStyle(context, 0.05),
          textAlign: TextAlign.center,
        ),
        Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01)),
        Text(
          title2,
          style: titleStyle(context, 0.035),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

TextStyle titleStyle(BuildContext context, double fontSize) {
  return TextStyle(
    fontSize: MediaQuery.of(context).size.width * fontSize,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
}