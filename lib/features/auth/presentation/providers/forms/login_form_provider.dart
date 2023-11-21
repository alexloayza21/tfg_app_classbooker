import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tfg_app/features/auth/presentation/providers/auth_provider.dart';

final loginFormProvider = StateNotifierProvider<LoginFormNotifier, LoginFormState>((ref) {
  final loginUserCallback = ref.watch(authProvider.notifier).loginUser;
  return LoginFormNotifier(loginUserCallback: loginUserCallback);
});

class LoginFormNotifier extends StateNotifier<LoginFormState> {
  final Function(String, String) loginUserCallback;

  LoginFormNotifier({required this.loginUserCallback}): super(LoginFormState());

  onEmailChange(String value){
    state = state.copyWith(
      email: value
    );
  }

  onPasswordChange(String value){
    state = state.copyWith(
      password: value
    );
  }

  onFormSubmit() async{
    state = state.copyWith(isPosting: true);
    await loginUserCallback(state.email, state.password);
    state = state.copyWith(isPosting: false);
  }
}

class LoginFormState {
  final bool isPosting;
  final String email;
  final String password;

  LoginFormState({
    this.isPosting = false, 
    this.email = '', 
    this.password = ''
  });

  LoginFormState copyWith({
    bool? isPosting,
    String? email,
    String? password
  }) => LoginFormState(
    isPosting: isPosting ?? this.isPosting,
    email: email ?? this.email,
    password: password ?? this.password
  );
}