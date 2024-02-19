import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/core.dart';
part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignIn signIn;
  SignInBloc(this.signIn) : super(SignInInitial()) {
    on<SignInWithNIKAndPassword>((event, emit) async {
      emit(SignInLoading());

      final result = await signIn.execute(nik: event.nik, password: event.password);
      result.fold(
        (failure) {
          emit(SignInFailure(message: failure.message));
        },
        (data) {
          emit(SignInSuccess(message: data));
        },
      );
    });
  }
}
