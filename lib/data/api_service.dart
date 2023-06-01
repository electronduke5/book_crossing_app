import 'dart:io';

import 'package:book_crossing_app/data/utils/api_const_url.dart';
import 'package:book_crossing_app/data/utils/http_exception.dart';
import 'package:dio/dio.dart';

mixin ApiService<T extends Object> {
  abstract String apiRoute;

  Future<List<T>> getAll({
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? params,
    dynamic id,
  }) async {
    final dio = Dio(
      BaseOptions(
        validateStatus: (status) => true,
        headers: {"Accept": "application/json"},
        queryParameters: params,
      ),
    );
    final response = await dio.get('${ApiConstUrl.baseUrl}$apiRoute${id == null ? '' : '/$id'}');
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
      throw Exception(response.data);
    }
    final jsonList = response.data;
    return jsonList.runtimeType is List<T>? jsonList.map((e) => fromJson(e)) : fromJson(jsonList);
  }

  Future<void> delete(int id) async {
    final dio = Dio(
      BaseOptions(
        validateStatus: (status) => true,
        headers: {"Accept": "application/json"},
      ),
    );
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
    FormData formData = FormData.fromMap(data);
    final dio = Dio(
      BaseOptions(
        headers: {"Accept": "application/json"},
        validateStatus: (status) => true,
      ),
    );
    try {
      final response = await dio.post(
        '${ApiConstUrl.baseUrl}$apiRoute${id == null ? '' : '/$id'}',
        data: formData,
      );
      if (response.statusCode != HttpStatus.ok &&
          response.statusCode != HttpStatus.created) {
        throw Exception(response.data['message']).getMessage;
      }
      final json = response.data;

      return fromJson(json);
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<T> put({
    required T Function(Map<String, dynamic>) fromJson,
    dynamic id,
    required Map<String, dynamic> data,
  }) async {
    data.addAll({
      '_method': 'PUT',
    });
    FormData formData = FormData.fromMap(data);
    final dio = Dio(
      BaseOptions(
        headers: {"Accept": "application/json"},
        validateStatus: (status) => true,
      ),
    );

    try {
      final response = await dio.post(
        '${ApiConstUrl.baseUrl}$apiRoute${id == null ? '' : '/$id'}',
        data: formData,
      );
      if (response.statusCode != HttpStatus.ok &&
          response.statusCode != HttpStatus.created) {
        throw Exception(response.data);
      }

      final json = response.data;
      return fromJson(json);
    } catch (error) {
      throw Exception(error);
    }
  }
}
