import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:tfg_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:tfg_app/features/shared/inputs/email.dart';
import 'package:tfg_app/features/shared/inputs/password.dart';

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
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([newEmail, state.password])
    );
  }

  onPasswordChange(String value){
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([newPassword, state.email])
    );
  }

  onIsAdminChanged(bool? value){
    state = state.copyWith(
      isAdmin: !value!
    );
  }

  onFormSubmit() async{
    _touchEveryField();
    if ( !state.isValid ) return;
    state = state.copyWith(isPosting: true);
    await registerUserCallback(state.username.trim(), state.email.value.trim(), state.password.value.trim(), state.isAdmin);
    state = state.copyWith(isPosting: false);
  }

  _touchEveryField(){
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    state = state.copyWith(
      isFormPosted: true,
      email: email,
      password: password,
      isValid: Formz.validate([email, password])
    );
  }
}

class RegisterFormState {
  final bool isPosting;
  final String username;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;
  final bool isAdmin;

  RegisterFormState({
    this.isPosting = false, 
    this.username = '', 
    this.isFormPosted = false, 
    this.isValid = false, 
    this.email = const Email.pure(), 
    this.password = const Password.pure(),
    this.isAdmin = false
  });

  RegisterFormState copyWith({
    bool? isPosting,
    String? username,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
    bool? isAdmin
  }) => RegisterFormState(
    isPosting: isPosting ?? this.isPosting,
    username: username ?? this.username,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    email: email ?? this.email,
    password: password ?? this.password,
    isAdmin: isAdmin ?? this.isAdmin
  );
}