
import 'package:cry/model/response_body_api.dart';
import 'package:cry/utils/http_util.dart';
import 'package:dio/dio.dart';
import 'package:edu_rating_app/config.dart';

class TeachApi {

  static page(data) async{
    ResponseBodyApi responseBodyApi;
    try {
      Response res = await Dio().post(Config.BaseUrl+'/adminteach/page',data: data);
      responseBodyApi = ResponseBodyApi.fromMap(res.data);
    } catch (e) {
      responseBodyApi = ResponseBodyApi(success: false, message: '请求出错了：' + e.toString());
    }
    return responseBodyApi;
    // return HttpUtil.post(Config.BaseUrl + '/adminteach/page', data: data);
  }
  static getById(data) {
    return HttpUtil.post(Config.BaseUrl +'/adminteach/getById', data: data);
  }
  static saveOrUpdate(data) async{ 
    // return HttpUtil.post(Config.BaseUrl +'/adminteach/saveOrUpdate', data: data);
    ResponseBodyApi responseBodyApi;
    try {
      Response res = await Dio().post(Config.BaseUrl+'/adminteach/saveOrUpdate',data: data);
      responseBodyApi = ResponseBodyApi.fromMap(res.data);
    } catch (e) {
      responseBodyApi = ResponseBodyApi(success: false, message: '请求出错了：' + e.toString());
    }
    return responseBodyApi;
  }
  static removeByIds(data)async{
    // return HttpUtil.post(Config.BaseUrl +'/adminteach/removeByIds', data: data);
    ResponseBodyApi responseBodyApi;
    try {
      Response res = await Dio().post(Config.BaseUrl+'/adminteach/removeByIds',data: data);
      responseBodyApi = ResponseBodyApi.fromMap(res.data);
    } catch (e) {
      responseBodyApi = ResponseBodyApi(success: false, message: '请求出错了：' + e.toString());
    }
    return responseBodyApi;
  }
}
