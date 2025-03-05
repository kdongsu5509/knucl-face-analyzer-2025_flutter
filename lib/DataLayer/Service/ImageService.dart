import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:knucl_face_analyzer_2025/DataLayer/Repository/ImageRepository.dart';
import 'package:knucl_face_analyzer_2025/DataLayer/Repository/ImageRepositoryLocal.dart';
import 'package:knucl_face_analyzer_2025/DataLayer/Service/my_dio.dart';

/**
 * @role : 이미지에 관련된 통신을 담당
 * @추상화 : 해당 프로젝트는 일회성이라 별도의 추상화 클래스 생성하지 않음.
 */
class ImageService {

  ImageRepository imageRepository = ImageRepositoryLocal();

  Dio dio = MyDio().get();

  Future<String> postImage(Uint8List encodedImage) {
    //convert Uint8List to MultipartFile
    MultipartFile file = MultipartFile.fromBytes(encodedImage, filename: "image.jpg");

    //send image to server
    return dio.post("${dotenv.env['baseUrl']}/image", data: FormData.fromMap({"img": file}))
      .then((response) => response.data);
  }

  Future<bool> deleteImage(int id) {

    //get image address from local repository
    String imgAddress = imageRepository.getImage(id);

    //delete image from server
    return dio.delete("${dotenv.env['baseUrl']}/image", data: {"imgAddress": imgAddress})
      .then((response) => response.statusCode == 200);
  }
}
