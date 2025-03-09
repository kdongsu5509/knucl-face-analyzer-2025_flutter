import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'my_dio.dart';

/**
 * @Structure :
 * 관상 분석은 서버에서 진행됩니다. 그리고 그 결과는 임시적으로만 저장하면 되고, 따로 저장할 필요는 없습니다.
 * 따라서 해당 클래스는 레포지토리를 거치지 않고, ViewModel과 Server를 직접 연결합니다.
 */

///
class AnalyzeService {

    Dio dio = MyDio().get();

    // Future<Stream<String>> getSSEStream(String imageUrl) async {
    //     FormData formData = FormData.fromMap({
    //         "imgAddress": imageUrl
    //     });
    //     try {
    //         final response = await dio.post(
    //             "${dotenv.env['baseUrl']}/analyze/face",
    //             data: formData,
    //             options: Options(
    //                 responseType: ResponseType.stream,
    //                 headers: {"Accept": "text/event-stream"}
    //             )
    //         );
    //
    //         final transformer = StreamTransformer<Uint8List, String>.fromHandlers(
    //             handleData: (Uint8List data, EventSink<String> sink) {
    //                 sink.add(utf8.decode(data));
    //             },
    //             handleError: (error, stack, sink) {
    //                 sink.addError(error, stack);
    //             },
    //             handleDone: (sink) {
    //                 sink.close();
    //             }
    //         );
    //
    //         if (response.statusCode == 200) {
    //             return response.data!.stream
    //                 .transform(transformer)
    //                 .where((String line) => !line.startsWith('data:') && (line.length == 1));// 명시적 변수 타입 선언으로 문제 해결
    //         } else {
    //             throw Exception('서버 에러: ${response.statusCode}');
    //         }
    //     } catch (e) {
    //         log("[에러] reason : ${e.toString()}");
    //         return Stream.error(e);  // 스트림 소비자에 에러를 전달
    //     }
    // }

    Future<String> getSSEStream(String imageUrl) async {
      FormData formData = FormData.fromMap({
        "imgAddress": imageUrl
      });
      try {
        final response = await dio.post(
            "${dotenv.env['baseUrl']}/analyze/face",
            data: formData,
        );

        if (response.statusCode == 200) {
          return response.data!;
        } else {
          throw Exception('서버 에러: ${response.statusCode}');
        }
      } catch (e) {
        log("[에러] reason : ${e.toString()}");
        return Future.error(e);  // 스트림 소비자에 에러를 전달
      }
    }
}

