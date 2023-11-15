import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tfg_app/features/auth/presentation/providers/auth_provider.dart';

final goRouterNotifierProvider = Provider((ref) {
  final authNotifier = ref.read(authProvider.notifier);
  return GoRouterNotifier(authNotifier);
});

class GoRouterNotifier extends ChangeNotifier {

  final AuthNotifier _authNotifier;
  AuthStatus _authStatus = AuthStatus.checking;
  bool _isAdmin = false;

  GoRouterNotifier(this._authNotifier){
    _authNotifier.addListener((state) {
      authStatus = state.authStatus;
      isAdmin = state.user!=null ? state.user!.admin : true;
    });
  }

  AuthStatus get authStatus => _authStatus;

  set authStatus(AuthStatus value){
    _authStatus = value;
    notifyListeners();
  }

  bool get isAdmin => _isAdmin;

  set isAdmin(bool value){
    _isAdmin = value;
    notifyListeners();
  }
  
}