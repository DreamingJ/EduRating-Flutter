
import 'package:cry/model/response_body_api.dart';
import 'package:cry/utils/http_util.dart';
import 'package:dio/dio.dart';
import 'package:edu_rating_app/config.dart';

class PersonApi {
  static list(data) {
    return HttpUtil.post(Config.BaseUrl+'/person/list', data: data);
  }
  static page(data) async{
    ResponseBodyApi responseBodyApi;
    try {
      Response res = await Dio().post(Config.BaseUrl+'/person/page',data: data);
      responseBodyApi = ResponseBodyApi.fromMap(res.data);
    } catch (e) {
      responseBodyApi = ResponseBodyApi(success: false, message: '请求出错了：' + e.toString());
    }
    return responseBodyApi;
    // return HttpUtil.post(Config.BaseUrl + '/person/page', data: data);
  }
  static getById(data) {
    return HttpUtil.post(Config.BaseUrl +'/person/getById', data: data);
  }
  static saveOrUpdate(data) async{ 
    // return HttpUtil.post(Config.BaseUrl +'/person/saveOrUpdate', data: data);
    ResponseBodyApi responseBodyApi;
    try {
      Response res = await Dio().post(Config.BaseUrl+'/person/saveOrUpdate',data: data);
      responseBodyApi = ResponseBodyApi.fromMap(res.data);
    } catch (e) {
      responseBodyApi = ResponseBodyApi(success: false, message: '请求出错了：' + e.toString());
    }
    return responseBodyApi;
  }
  static removeByIds(data)async{
    // return HttpUtil.post(Config.BaseUrl +'/person/removeByIds', data: data);
    ResponseBodyApi responseBodyApi;
    try {
      Response res = await Dio().post(Config.BaseUrl+'/person/removeByIds',data: data);
      responseBodyApi = ResponseBodyApi.fromMap(res.data);
    } catch (e) {
      responseBodyApi = ResponseBodyApi(success: false, message: '请求出错了：' + e.toString());
    }
    return responseBodyApi;
  }
}
