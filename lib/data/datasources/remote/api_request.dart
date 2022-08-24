import 'package:dio/dio.dart';
import 'package:flutter_app_sale_06072022/common/constants/api_constant.dart';
import 'package:flutter_app_sale_06072022/data/datasources/remote/dio_client.dart';

class ApiRequest {
  late Dio _dio;
  
  ApiRequest(){
    _dio = DioClient.instance.dio;
  }
  
  Future signIn(String email, String password) {
    return _dio.get(ApiConstant.SIGN_IN_URL, queryParameters: {
      "email": email,
      "password": password
    });
  }
}