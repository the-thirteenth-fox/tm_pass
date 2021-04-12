import 'package:dio/dio.dart';
import 'package:tm_pass/models/video_data.dart';

import '../untils.dart';

class RestApiManager {
  BaseOptions options = new BaseOptions(
    // connectTimeout: 5000,
    // receiveTimeout: 3000,
    headers: {
      "Accept": "application/json",
      'Content-Type': 'multipart/form-data'
    },
  );
  Future<VData> getVideoByCode(String code) async {
    try {
      var response = await Dio(options).get('$API_URL/$code');
      print(response);
      return VData.fromJson(response.data);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<VData> uploadVideoByCode(String code, String filePath) async {
    String fileName = filePath.split('/').last;
    Dio dio = new Dio(options);
    try {
      var formData = FormData.fromMap({
        'File': await MultipartFile.fromFile(filePath, filename: fileName),
        'Code': code,
        'Template ': 1,
      });
      var response = await dio.post(API_URL, data: formData);
      print(response);
      return VData.fromJson(response.data);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
