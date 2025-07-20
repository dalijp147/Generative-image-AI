import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';

class PromptRepository {
  static Future<Uint8List?> genrateImage(String prompt) async {
    try {
      String url = "https://api.vyro.ai/v2/image/generations";
      Map<String, dynamic> headers = {
        'Authorization':
            'Bearer vk-5ovgHZmDU7nN2OoOBb2btSyohpXpnczE6IKEXF2Pm3C7Ez8',
      };
      Map<String, String> payload = {
        'prompt': prompt,
        'style': 'realistic',
        'aspect_ratio': '1:1',
        'seed': '5',
      };
      FormData formData = FormData.fromMap(payload);

      Dio dio = Dio();
      dio.options = BaseOptions(
        headers: headers,
        responseType: ResponseType.bytes,
      );
      final response = await dio.post(url, data: formData);
      if (response.statusCode == 200) {
        log(response.data.runtimeType.toString());
        log(response.data.toString());
        Uint8List uint8List = Uint8List.fromList(response.data);
        return uint8List;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
