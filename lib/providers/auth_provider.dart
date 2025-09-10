import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthState {
  final String firstName;
  final String lastName;
  final String email;
  final String dateOfBirth;
  final String password;
  final String confirmPassword;

  AuthState({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.dateOfBirth = '',
    this.password = '',
    this.confirmPassword = '',
  });

  AuthState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? dateOfBirth,
    String? password,
    String? confirmPassword,
  }) {
    return AuthState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }
}

final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  void updateFirstName(String value) {
    state = state.copyWith(firstName: value);
  }

  void updateLastName(String value) {
    state = state.copyWith(lastName: value);
  }

  void updateEmail(String value) {
    state = state.copyWith(email: value);
  }

  void updateDateOfBirth(String value) {
    state = state.copyWith(dateOfBirth: value);
  }

  void updatePassword(String value) {
    state = state.copyWith(password: value);
  }

  void updateConfirmPassword(String value) {
    state = state.copyWith(confirmPassword: value);
  }

  bool validateForm() {
    if (state.firstName.isEmpty) return false;
    if (state.lastName.isEmpty) return false;
    if (state.email.isEmpty) return false;
    if (state.dateOfBirth.isEmpty) return false;
    if (state.password.isEmpty) return false;
    if (state.confirmPassword.isEmpty) return false;
    if (state.password != state.confirmPassword) return false;
    return true;
  }
}
