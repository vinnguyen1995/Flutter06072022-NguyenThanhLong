import '../../../common/bases/base_event.dart';

class SignInEvent extends BaseEvent {
  String email, password;

  SignInEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [];
}