import 'package:flutter_app_sale_06072022/common/bases/base_event.dart';
import 'package:flutter_app_sale_06072022/data/repositories/sign_in_repository.dart';

import '../../../common/bases/base_bloc.dart';

class SignInBloc extends BaseBloc{
  late SignInRepository _repository;

  void updateRepository(SignInRepository signInRepository) {
    _repository = signInRepository;
  }
  @override
  void dispatch(BaseEvent event) {
    print(event.toString());
  }

}