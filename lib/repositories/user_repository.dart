// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_scroll_mixin/models/user_model.dart';

class UserRepository {
  final Dio _dio;

  UserRepository({
    required Dio dio,
  }) : _dio = dio;
//! eniando do getUser para enviar para o backend
  // Future<List<UserModel>> getUsers() async {
  Future<List<UserModel>> getUsers(int page, int limit) async {
    try {
      //simulação de internet ruim no carregamento de página
      await Future.delayed(const Duration(seconds: 2));
      print('Buscando página>>> $page');
      //!enviado por aqui o backend
      final result = await _dio.get('/users', queryParameters: {
        'page': page,
        'limit': limit,
      });

      return result.data
          .map<UserModel>((user) => UserModel.fromMap(user))
          .toList();
    } on DioException catch (e, s) {
      log('Erro ao buscar usuarios', error: e, stackTrace: s);
      throw Exception();
    }
  }
}
