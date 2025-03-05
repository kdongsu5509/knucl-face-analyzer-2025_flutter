import 'dart:typed_data';
import '../Service/ImageService.dart';
import 'ImageRepository.dart';

class ImageRepositoryLocal implements ImageRepository {

  ImageService _imageService = ImageService();

  int _id = 0;

  //ID와 이미지 S3 주소를 저장하는 맵
  Map<int, String> _images = {};

  @override
  Future<int> saveImage(Uint8List encodedImage) async {
    int currentId = _id++; // 현재 ID를 저장하고 증가

    //서버에 이미지 저장 요청
    String imageUrl = await _imageService.postImage(encodedImage);

    //이미지 ID와 S3 주소를 저장
    _images[currentId] = imageUrl; // 이미지 저장
    return currentId; // 저장된 이미지의 ID 반환
  }

  /**
   * @role : 이미지 ID를 통해 이미지를 가져옴
   * @param id : 이미지 ID
   * @return : 이미지 URL
   */
  ///
  @override
  String getImage(int id) {
    //check the id is valid
    if(!_images.containsKey(id)) {
      return "Invalid ID";
    }
    return _images[id]!;
  }

  @override
  Future<bool> deleteImage(int id) async {
    //check the id is valid
    if(!_images.containsKey(id)) {
      return Future.value(false);
    }
    _images.remove(id);
    return Future.value(true);
  }
}