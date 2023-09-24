import 'dart:async';
import 'dart:developer';

import 'package:final_exam/features/authentication/repos/authentication_repo.dart';
import 'package:final_exam/router.dart';
import 'package:final_exam/util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SocialAuthViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _repository;
  late final GoRouter _router;

  @override
  FutureOr<void> build() {
    _repository = ref.read(authRepo);
    _router = ref.read(routerProvider);
  }

  Future<void> githubSingIn() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => await _repository.githubSignin(),
    );
    if (state.hasError) {
      log(' error in social_auth_vm.dart');
      showFirebaseErrorSnack(state.error);
    } else {
      _router.go("/home");
    }
  }
}

final socialAuthProvider = AsyncNotifierProvider<SocialAuthViewModel, void>(
  () => SocialAuthViewModel(),
);
