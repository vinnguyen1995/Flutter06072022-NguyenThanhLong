import 'package:flutter_app_sale_06072022/data/datasources/remote/api_request.dart';

class AuthenticationRepository {
  late ApiRequest _apiRequest;

  void update(ApiRequest apiRequest) {
    _apiRequest = apiRequest;
  }

  Future signInRequest(String email, String password) {
    return _apiRequest.signIn(email, password);
  }

  Future sigUpRequest(String email, String name, String phone, String password, String address) {
    return _apiRequest.signIn(email, password);
  }
}