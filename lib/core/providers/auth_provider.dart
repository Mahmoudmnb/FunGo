// lib/core/providers/auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fun_go_app/injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus { loading, unauthenticated, authenticated }

final authProvider = StateProvider<AuthStatus>((ref) {
  SharedPreferences sh = sl.get<SharedPreferences>();
  String? user = sh.getString('user');
  if (user != null) {
    return AuthStatus.authenticated;
  }
  return AuthStatus.unauthenticated;
});

extension AuthStatusX on AuthStatus {
  T when<T>({
    required T Function() loading,
    required T Function() unauthenticated,
    required T Function() authenticated,
  }) {
    switch (this) {
      case AuthStatus.loading:
        return loading();
      case AuthStatus.unauthenticated:
        return unauthenticated();
      case AuthStatus.authenticated:
        return authenticated();
    }
  }
}
