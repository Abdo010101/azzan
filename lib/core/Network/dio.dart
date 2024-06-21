import 'dart:async';
import 'dart:developer';

import 'package:azzan/core/Network/endpoint.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// Class that makes API call easier
class DioManager {
  Dio? _dioInstance;

  Dio? get dio {
    _dioInstance ??= initDio();
    return _dioInstance;
  }

  Dio initDio() {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: BASEURL,
        headers: <String, String>{},
        sendTimeout: Duration(seconds: 30000),
        connectTimeout: Duration(seconds: 20000),
        receiveTimeout: Duration(seconds: 60000),
      ),
    );
    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: true,
          maxWidth: 120,
        ),
      );
    }
    return dio;
  }

  void update() => _dioInstance = initDio();

  /// DIO GET
  /// take [path], concrete route
  Future<Response> get(
    String path, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? parameters,
  }) async {
    return await dio!
        .get(
      path,
      queryParameters: parameters,
      options: Options(headers: headers),
    )
        .then((response) {
      return response;
    }).catchError((dynamic error) async {
      log(error.toString());
    });
  }

  /// DIO POST
  /// take [path], concrete route
  Future<Response> post(
    String path, {
    Map<String, dynamic>? headers,
    dynamic body,
  }) async {
    return await dio!
        .post(
      path,
      data: body,
      options: Options(headers: headers),
    )
        .then((response) {
      return response;
    }).catchError((dynamic error) {
      log(error.toString());
    });
  }

  /// DIO PUT
  /// take [path], concrete route
  Future<Response> put(
    String path, {
    Map<String, dynamic>? headers,
    dynamic body,
  }) async {
    return await dio!
        .put(
      path,
      data: body,
      options: Options(headers: headers),
    )
        .then((response) {
      return response;
    }).catchError((dynamic error) {
      log(error.toString());
    });
  }

  /// DIO DELETE
  /// take [path], concrete route
  Future<Response> delete(
    String path, {
    Map<String, dynamic>? headers,
    dynamic body,
  }) async {
    return await dio!
        .delete(
      path,
      data: body,
      options: Options(headers: headers),
    )
        .then((response) {
      return response;
    }).catchError((dynamic error) {
      log(error.toString());
    });
  }
}
