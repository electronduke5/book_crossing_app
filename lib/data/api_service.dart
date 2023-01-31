import 'dart:io';

import 'package:book_crossing_app/data/utils/api_const_url.dart';
import 'package:dio/dio.dart';

mixin ApiService<T extends Object> {
  abstract String apiRoute;

  Future<List<T>> getAll({
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final dio = Dio(
      BaseOptions(
        validateStatus: (status) => true,
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

  Future<T> post({
    required T Function(Map<String, dynamic>) fromJson,
    int? id,
    required Map<String, dynamic> data,
  }) async {
    final dio = Dio(
      BaseOptions(
        validateStatus: (status) => true,
      ),
    );

    final response = await dio
        .post('${ApiConstUrl.baseUrl}$apiRoute${id == null ? '' : '/$id'}', data: data);
    if (response.statusCode != HttpStatus.ok) {
      throw Exception(['Error =_-']);
    }
    final json = response.data;
    print(json);

    return fromJson(json);
  }
}
