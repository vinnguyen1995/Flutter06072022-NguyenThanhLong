import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_app_sale_06072022/common/bases/base_event.dart';
import 'package:flutter_app_sale_06072022/data/datasources/remote/app_response.dart';
import 'package:flutter_app_sale_06072022/data/datasources/remote/dto/user_dto.dart';
import 'package:flutter_app_sale_06072022/data/repositories/authentication_repository.dart';
import 'package:flutter_app_sale_06072022/presentation/features/sign_in/sign_in_event.dart';

import '../../../common/bases/base_bloc.dart';
import '../../../data/model/user.dart';

class SignInBloc extends BaseBloc {
  StreamController<User> userData = StreamController();
  late AuthenticationRepository _repository;

  void updateRepository(AuthenticationRepository signInRepository) {
    _repository = signInRepository;
  }

  @override
  void dispatch(BaseEvent event) {
    switch (event.runtimeType) {
      case SignInEvent:
        _handleSignIn(event as SignInEvent);
        break;
    }
  }

  void _handleSignIn(SignInEvent event) async {
    loadingSink.add(true);
    try {
      Response response =
          await _repository.signInRequest(event.email, event.password);
      AppResponse<UserDto> userResponse =
          AppResponse.fromJson(response.data, UserDto.fromJson);
      UserDto? userDto = userResponse.data;
      if (userDto != null) {
        User user = User(
            userDto.email,
            userDto.name,
            userDto.phone,
            userDto.registerDate,
            userDto.token);
        userData.sink.add(user);
        progressSink.add(SignInSuccessEvent(message: "Đăng nhập thành công"));
      }
    } on DioError catch (e) {
      messageSink.add(e.response?.data["message"]);
    } catch (e) {
      messageSink.add(e.toString());
    }
    loadingSink.add(false);
  }
}
