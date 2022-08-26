import 'package:dio/dio.dart';
import 'package:flutter_app_sale_06072022/common/bases/base_event.dart';
import 'package:flutter_app_sale_06072022/data/repositories/sign_in_repository.dart';
import 'package:flutter_app_sale_06072022/presentation/features/sign_in/sign_in_event.dart';

import '../../../common/bases/base_bloc.dart';

class SignInBloc extends BaseBloc{
  late SignInRepository _repository;

  void updateRepository(SignInRepository signInRepository) {
    _repository = signInRepository;
  }

  @override
  void dispatch(BaseEvent event) {
    switch(event.runtimeType) {
      case SignInEvent:
        _handleSignIn(event as SignInEvent);
        break;
    }
  }

  void _handleSignIn(SignInEvent event) async{
    loadingSink.add(true);
    try {
      Response response = await _repository.signInRequest(event.email, event.password);
      print(response.data.toString());
    } on DioError catch(e) {
      print(e.toString());
    } catch(e) {
      print(e.toString());
    }
  }

}