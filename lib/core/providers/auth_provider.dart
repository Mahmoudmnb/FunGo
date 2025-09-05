// lib/core/providers/auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AuthStatus { loading, unauthenticated, authenticated }

final authProvider = StateProvider<AuthStatus>((ref) {
  // مؤقتاً خليها ترجع unauthenticated
  // بعدين بتضيفي SharedPreferences/Firebase
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
