import 'dart:convert';
import 'package:http/http.dart';

class NetworkResponse {
  final bool isSucess;
  final int statusCode;
  final Map<String, dynamic>? data;
  final String? errorMessage;
  NetworkResponse({
    required this.isSucess,
    required this.statusCode,
    this.data,
    this.errorMessage,
  });
}

class NetworkClient {
  static Future<NetworkResponse> getRequest({
    required String url,
    Map<String, String>? headers,
  }) async {
    try {
      Uri uri = Uri.parse(url);

      Response response = await get(uri, headers: headers);

      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          isSucess: true,
          statusCode: response.statusCode,
          data: decodedJson,
        );
      } else if (response.statusCode == 401) {
        return NetworkResponse(
          isSucess: false,
          statusCode: response.statusCode,
          errorMessage: 'Unauthorized user.Please login again',
        );
      } else {
        final decodedJson = jsonDecode(response.body);
        String errorMessage = decodedJson['data'] ?? 'Something went Wrong';
        return NetworkResponse(
          isSucess: false,
          statusCode: response.statusCode,
          errorMessage: errorMessage,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSucess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }
}
