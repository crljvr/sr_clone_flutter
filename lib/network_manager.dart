import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
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
  DioNetworkManager(this.dio) {
    dio.options.connectTimeout = const Duration(milliseconds: 5000);
    dio.interceptors.add(RetryOnConnectionChangeInterceptor(DioConnectivityRequestRetrier(dio: dio, connectivity: Connectivity())));
  }

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

class RetryOnConnectionChangeInterceptor extends Interceptor {
  const RetryOnConnectionChangeInterceptor(this.requestRetrier);

  final DioConnectivityRequestRetrier requestRetrier;

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (!_shouldRetry(err)) return super.onError(err, handler);
    try {
      await requestRetrier.scheduleRequestRetry(err.requestOptions);
    } on DioError catch (err) {
      return super.onError(err, handler);
    }
  }

  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.connectionError && err.error != null && err.error is SocketException;
  }
}

class DioConnectivityRequestRetrier {
  const DioConnectivityRequestRetrier({
    required this.dio,
    required this.connectivity,
  });

  final Dio dio;
  final Connectivity connectivity;

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    StreamSubscription? streamSubscription;
    final responseCompleter = Completer<Response>();

    streamSubscription = connectivity.onConnectivityChanged.listen(
      (connectivityResult) async {
        print(connectivityResult);
        if (connectivityResult != ConnectivityResult.none) {
          await streamSubscription?.cancel();
          // Complete the completer instead of returning
          responseCompleter.complete(
            dio.request(
              requestOptions.path,
              cancelToken: requestOptions.cancelToken,
              data: requestOptions.data,
              onReceiveProgress: requestOptions.onReceiveProgress,
              onSendProgress: requestOptions.onSendProgress,
              queryParameters: requestOptions.queryParameters,
            ),
          );
        }
      },
    );

    return responseCompleter.future;
  }
}
