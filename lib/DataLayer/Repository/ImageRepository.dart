import 'dart:typed_data';

abstract class ImageRepository {
  Future<int> saveImage(Uint8List encodedImage);
  Future<String> getImage(int id);
  Future<bool> deleteImage(int id);
}
