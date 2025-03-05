import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:knucl_face_analyzer_2025/DataLayer/Service/my_dio.dart';

/**
 * @role : 이미지에 관련된 통신을 담당
 * @추상화 : 해당 프로젝트는 일회성이라 별도의 추상화 클래스 생성하지 않음.
 */
class ImageService {
  Dio dio = MyDio().get();

  Future<String> postImage(Uint8List encodedImage) {
    //convert Uint8List to MultipartFile
    MultipartFile file = MultipartFile.fromBytes(encodedImage, filename: "image.jpg");

    //send image to server
    return dio.post("http://172.29.89.217:8080/image", data: FormData.fromMap({"img": file}))
      .then((response) => response.data);
  }

  Future<bool> deleteImage(int id) {
    //delete image from server
    return dio.delete("http://172.29.89.217:8080/image/$id")
      .then((response) => response.statusCode == 200);
  }
}
