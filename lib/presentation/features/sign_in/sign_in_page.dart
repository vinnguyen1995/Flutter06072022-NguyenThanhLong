import 'package:flutter/material.dart';
import 'package:flutter_app_sale_06072022/common/bases/base_widget.dart';
import 'package:flutter_app_sale_06072022/data/datasources/remote/api_request.dart';
import 'package:flutter_app_sale_06072022/data/repositories/sign_in_repository.dart';
import 'package:flutter_app_sale_06072022/presentation/features/sign_in/sign_in_bloc.dart';
import 'package:flutter_app_sale_06072022/presentation/features/sign_in/sign_in_event.dart';
import 'package:provider/provider.dart';
class SignInPage extends StatefulWidget {

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      providers: [
        Provider(create: (context) => ApiRequest()),
        ProxyProvider<ApiRequest, SignInRepository>(
          update: (context, request, repository){
            repository?.update(request);
            return repository ?? SignInRepository()..update(request);
          },
        ),
        ProxyProvider<SignInRepository, SignInBloc>(
          update: (context, repository, bloc){
            bloc?.updateRepository(repository);
            return bloc ?? SignInBloc()..updateRepository(repository);
          },
        ),
      ],
      child: SignInContainer(),
    );
  }
}

class SignInContainer extends StatefulWidget {
  const SignInContainer({Key? key}) : super(key: key);

  @override
  State<SignInContainer> createState() => _SignInContainerState();
}

class _SignInContainerState extends State<SignInContainer> {
  late SignInBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<SignInBloc>();
    _bloc.eventSink.add(SignInEvent(email: "hello", password: "123"));
  }
  @override
  Widget build(BuildContext context) {
    return Text("Demo");
  }
}

