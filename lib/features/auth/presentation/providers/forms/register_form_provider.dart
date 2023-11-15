import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tfg_app/features/auth/presentation/providers/auth_provider.dart';

final registerFormProvider = StateNotifierProvider<RegisterFormNotifier, RegisterFormState>((ref) {
  final registerUserCallback = ref.watch(authProvider.notifier).registerUser;
  return RegisterFormNotifier(registerUserCallback: registerUserCallback);
});

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  final Function(String, String, String, bool) registerUserCallback;

  RegisterFormNotifier({required this.registerUserCallback}): super(RegisterFormState());
  
  onUsernameChange(String value){
    state = state.copyWith(
      username: value
    );
  }

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

  onIsAdminChanged(bool? value){
    state = state.copyWith(
      isAdmin: !value!
    );
  }

  onFormSubmit() async{
    state = state.copyWith(isPosting: true);
    await registerUserCallback(state.username, state.email, state.password, state.isAdmin);
    state = state.copyWith(isPosting: false);
  }
}

class RegisterFormState {
  final bool isPosting;
  final String username;
  final String email;
  final String password;
  final bool isAdmin;

  RegisterFormState({
    this.isPosting = false, 
    this.username = '', 
    this.email = '', 
    this.password = '', 
    this.isAdmin = false
  });

  RegisterFormState copyWith({
    bool? isPosting,
    String? username,
    String? email,
    String? password,
    bool? isAdmin
  }) => RegisterFormState(
    isPosting: isPosting ?? this.isPosting,
    username: username ?? this.username,
    email: email ?? this.email,
    password: password ?? this.password,
    isAdmin: isAdmin ?? this.isAdmin
  );
}