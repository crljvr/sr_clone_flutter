import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class NetworkError implements Exception {}

class Endpoint {
  const Endpoint({
    required this.path,
    this.queryParameters,
  });

  final String path;
  final Map<String, String>? queryParameters;
}

// ignore: one_member_abstracts
abstract class NetworkManager {
  Future<Map<String, dynamic>> get(Endpoint endpoint);
  Future<Map<String, dynamic>> post(Endpoint endpoint);
}

class DioNetworkManager implements NetworkManager {
  DioNetworkManager(this.dio);

  final Dio dio;

  @override
  Future<Map<String, dynamic>> get(Endpoint endpoint) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(endpoint.path, queryParameters: endpoint.queryParameters);
      if (response.data == null) throw NetworkError();

      return response.data!;
    } on DioError catch (error) {
      _printDioError(error);
      throw NetworkError();
    }
  }

  @override
  Future<Map<String, dynamic>> post(Endpoint endpoint) {
    // TODO: implement post
    throw UnimplementedError();
  }

  void _printDioError(DioError error) {
    debugPrint('''
      ❌ DIO ERROR ❌
      ERROR MESSAGE: ${error.message}
      ERROR PATH: ${error.requestOptions.path}
      ''');
  }
}
