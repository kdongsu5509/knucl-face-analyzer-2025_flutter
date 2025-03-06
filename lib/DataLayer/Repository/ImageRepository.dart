import 'dart:typed_data';

abstract class ImageRepository {
  Future<String> saveImage(Uint8List encodedImage);
  String getImage(int id);
  Future<bool> deleteImage(int id);
}
