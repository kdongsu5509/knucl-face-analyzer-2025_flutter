import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_selector/file_selector.dart';
import 'package:knucl_face_analyzer_2025/DataLayer/Repository/ImageRepository.dart';
import '../DataLayer/Repository/ImageRepositoryLocal.dart';

const XTypeGroup typeGroup = XTypeGroup(
  label: 'images',
  extensions: ['jpg', 'png'],
);

//내장 이미지 선택기를 사용하여 이미지를 선택하고 이미지를 Uint8List로 변환하여 반환
//비동기로 이미지를 관리함 Provider
final imageSelectProvider = FutureProvider.autoDispose<Uint8List>((ref) async {
  final XFile? file = await openFile(acceptedTypeGroups: [typeGroup]);
  if (file != null) {
    return await file.readAsBytes();
  } else {
    throw Exception('No file selected');
  }
});

class ImageUploadViewModel {
  final ImageRepository _imageRepository = ImageRepositoryLocal();

  Future<int> saveImage(Uint8List encodedImage) async {
    return await _imageRepository.saveImage(encodedImage);
  }

  Future<String> getImage(int id) async {
    return await _imageRepository.getImage(id);
  }

  Future<bool> deleteImage(int id) async {
    return await _imageRepository.deleteImage(id);
  }
}
