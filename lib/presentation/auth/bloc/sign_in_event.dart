part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInWithNIKAndPassword extends SignInEvent {
  final String nik;
  final String password;

  const SignInWithNIKAndPassword({
    required this.nik,
    required this.password,
  });

  @override
  List<Object> get props => [nik, password];
}
