// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_scroll_mixin/models/user_model.dart';

class UserRepository {
  final Dio _dio;

  UserRepository({
    required Dio dio,
  }) : _dio = dio;

  Future<List<UserModel>> getUser() async {
    try {
      final result = await _dio.get('/users');

      return result.data.map((user) => UserModel.fromMap(user)).toList();
    } on DioException catch (e, s) {
      log('Erro ao buscar usuarios', error: e, stackTrace: s);
      throw Exception();
    }
  }
}