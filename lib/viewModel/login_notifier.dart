import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:plie/model/auth_response.dart';

class LoginState {
  final bool isLoading;
  final AuthResponse? authResponse;

  const LoginState({
    this.isLoading = false,
    this.authResponse,
  });

  LoginState copyWith({
    bool? isLoading,
    AuthResponse? authResponse,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      authResponse: authResponse,
    );
  }
}

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(const LoginState());

  static const String baseUrl = "http://3.7.81.243/projects/plie-api/public/api";

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true);

    try {
      final request = http.MultipartRequest(
        "POST",
        Uri.parse("$baseUrl/login"),
      );
      request.fields['email'] = email;
      request.fields['password'] = password;

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final auth = AuthResponse.fromJson(data);
        state = state.copyWith(isLoading: false, authResponse: auth);
      } else {
        state = state.copyWith(
          isLoading: false,
          authResponse: AuthResponse(
            success: false,
            message: "Login failed: ${response.body}",
          ),
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        authResponse: AuthResponse(
          success: false,
          message: "Error: $e",
        ),
      );
    }
  }
}

final loginProvider =
StateNotifierProvider<LoginNotifier, LoginState>((ref) => LoginNotifier());
