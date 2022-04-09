import 'dart:io';

import 'package:dio/dio.dart';
import 'package:edu_rating_app/config.dart';
import 'package:flutter/cupertino.dart';

//对dio进行封装， 带token方便拦截器
class DioHttp {
  late Dio _client;
  late BuildContext context;
  //当我们在 build 函数中使用Navigator.of(context)的时候，这个context实际上是通过 MyApp 这个widget创建出来的Element对象，而of方法向上寻找祖先节点的时候（MyApp的祖先节点）
  //of方法就是获取上下文数据的一个封装
  static DioHttp of(BuildContext context) {
    return DioHttp._internal(context);
  }

  DioHttp._internal(BuildContext context) {
    if (context != this.context) {
      this.context = context;
      var options = BaseOptions(
          baseUrl: Config.BaseUrl,
          connectTimeout: 1000 * 10,
          receiveTimeout: 1000 * 3,
          extra: {'context': context});

      var client = Dio(options);
      _client = client;
    }
  }

  Future<Response<Map<String, dynamic>>> get(String path,
      {Map<String, dynamic>? params, String? token}) async {
    Options requestOptions = Options(headers: {'Authorization': token});
    return await _client.get(
      path,
      queryParameters: params,
      options: requestOptions,
    );
  }

  Future<Response<Map<String, dynamic>>> post(String path,
      [Map<String, dynamic>? params, String? token]) async {
    Options requestOptions = Options(headers: {'Authorization': token});
    return await _client.post(
      path,
      data: params,
      options: requestOptions,
    );
  }

  Future<Response<Map<String, dynamic>>> postFormData(String path,
      [Map<String, dynamic>? params, String? token]) async {
    var requestOptions = Options(
      // TODO: contentType: ContentType.parse('multipart/form-data'),
      headers: {'Authorization': token});
    return await _client.post(
      path,
      data: params,
      options: requestOptions,
    );
  }
}
