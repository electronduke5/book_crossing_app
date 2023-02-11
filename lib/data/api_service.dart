import 'dart:developer';
import 'dart:io';

import 'package:book_crossing_app/data/utils/api_const_url.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

mixin ApiService<T extends Object> {
  abstract String apiRoute;

  Future<List<T>> getAll({
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? params,
    int? id,
  }) async {
    final dio = Dio(
      BaseOptions(
        validateStatus: (status) => true,
        headers: {"Accept": "application/json"},
        queryParameters: params,
      ),
    );

    final response = await dio.get('${ApiConstUrl.baseUrl}$apiRoute');
    if (response.statusCode != HttpStatus.ok) {
      return [];
    }
    final jsonList = response.data as List<dynamic>;
    return jsonList.map((e) => fromJson(e)).toList();
  }

  Future<T> get(
      {required T Function(Map<String, dynamic>) fromJson, int? id}) async {
    final dio = Dio(
      BaseOptions(
        validateStatus: (status) => true,
        headers: {"Accept": "application/json"},
      ),
    );

    final response =
        await dio.get('${ApiConstUrl.baseUrl}$apiRoute/${id ?? ''}]');
    if (response.statusCode != HttpStatus.ok) {
      throw Exception(['Error =_-']);
    }
    final jsonList = response.data;
    return jsonList.map((e) => fromJson(e));
  }

  Future<void> delete(int id) async {
    final dio = Dio(
      BaseOptions(
        validateStatus: (status) => true,
        headers: {"Accept": "application/json"},
      ),
    );
    Logger logger = Logger();
    logger.i('${ApiConstUrl.baseUrl}$apiRoute/$id');

    final response = await dio.delete('${ApiConstUrl.baseUrl}$apiRoute/$id');
    if (response.statusCode != HttpStatus.noContent) {
      throw Exception(['Error =_-']);
    }
  }

  Future<T> post({
    required T Function(Map<String, dynamic>) fromJson,
    dynamic id,
    required Map<String, dynamic> data,
  }) async {
    print('data: ${data}');
    final dio = Dio(
      BaseOptions(
        headers: {"Accept": "application/json"},
        validateStatus: (status) => true,
      ),
    );

    print('url: ${ApiConstUrl.baseUrl}$apiRoute${id == null ? '' : '/$id'}');
    try {
      final response = await dio.post(
        '${ApiConstUrl.baseUrl}$apiRoute${id == null ? '' : '/$id'}',
        data: data,
      );
      log('response.statusCode: ${response.statusCode}');
      if (response.statusCode != HttpStatus.ok &&
          response.statusCode != HttpStatus.created) {
        throw Exception(['Error =_-']);
      }
      final json = response.data;
      print(json);

      return fromJson(json);
    } catch (error) {
      print(error.toString());
      throw Exception(error);
    }
  }
}
