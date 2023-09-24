import 'dart:async';
import 'dart:developer';

import 'package:final_exam/features/authentication/repos/authentication_repo.dart';
import 'package:final_exam/router.dart';
import 'package:final_exam/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _repository;
  late final GoRouter _router;

  @override
  FutureOr<void> build() {
    _repository = ref.read(authRepo);
    _router = ref.read(routerProvider);
  }

  Future<void> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => await _repository.signIn(email, password),
    );
    if (state.hasError) {
      log('login error in login_view_model.dart');
      showFirebaseErrorSnack(state.error);
    } else {
      log('route to /home');
      _router.go("/home");
    }
  }
}

final loginProvider = AsyncNotifierProvider<LoginViewModel, void>(
  () => LoginViewModel(),
);
